-- This Outline provider is for plaintext files.
-- It however expects the headers and the end of document marker to be in
-- certain format:
--      H1:
--          1.  SYSTEM OVERVIEW
--          ===================
--
--      H2:
--          1.1  PRE-FLIGHT CHECKLIST
--          -------------------------
--
--      End of document marker:
--          [END OF DOCUMENT]

local M = {
  name = 'plaintext',
}

local utils = require('outline.utils')

---@param bufnr integer
---@param config table?
---@return boolean ft_is_plaintext
function M.supports_buffer(bufnr, config)
  local ft = utils.buf_get_option(bufnr, 'ft')
  if config and config.filetypes then
    for _, ft_check in ipairs(config.filetypes) do
      if ft_check == ft then
        return true
      end
    end
  end
  return ft == 'text'
end

-- Parses plaintext files and returns a table of SymbolInformation[] which is
-- used by the plugin to show the outline.
---@return outline.ProviderSymbol[]
function M.handle_plaintext()
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local level_symbols = { }

    for line, value in ipairs(lines) do
        local next_value = lines[line + 1]

        local is_all_upper_case = #value ~= 0 and value == string.upper(value)
        local is_h1 = false
        local is_h2 = false
        local is_end_of_document = value == '[END OF DOCUMENT]'
        if is_all_upper_case and next_value ~= nil then
            if string.match(next_value, "^=+$") then
                is_h1 = true
            elseif string.match(next_value, "^-+$") then
                is_h2 = true
            end
        end

        local function generate_entry()
            return {
                kind = 15,
                name = value,
                selectionRange = {
                    start = { character = 0, line = line - 1 },
                    ['end'] = { character = 0, line = line - 1 },
                },
                range = {
                    start = { character = 0, line = line - 1 },
                    ['end'] = { character = 0, line = line - 1 },
                },
                children = {},
            }
        end

        local function set_end_for_previous_h2(last_h1_index, last_h2_index)
            if last_h2_index ~= 0 then
                level_symbols[last_h1_index].children[last_h2_index].selectionRange['end'].line = line - 2
                level_symbols[last_h1_index].children[last_h2_index].range['end'].line = line - 2
            end
        end
            
        local function set_end_for_previous_h1()
            local last_h1_index = #level_symbols
            if last_h1_index ~= 0 then
                level_symbols[last_h1_index].selectionRange['end'].line = line - 2
                level_symbols[last_h1_index].range['end'].line = line - 2
                set_end_for_previous_h2(last_h1_index, #level_symbols[last_h1_index].children)
            end
        end

        if is_h1 then
            set_end_for_previous_h1()
            table.insert(level_symbols, generate_entry())
        elseif is_h2 then
            local last_h1_index = #level_symbols
            local children = level_symbols[last_h1_index].children
            set_end_for_previous_h2(last_h1_index, #children)
            table.insert(children, generate_entry())
        elseif is_end_of_document then
            set_end_for_previous_h1()
        end
    end
    return level_symbols
end

---@param on_symbols fun(symbols?:outline.ProviderSymbol[], opts?:table)
---@param opts table
function M.request_symbols(on_symbols, opts)
    on_symbols(M.handle_plaintext(), opts)
end

return M
