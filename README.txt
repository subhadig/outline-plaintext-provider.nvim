1.  OUTLINE PLAINTEXT PROVIDER
==============================

An Outline[1] provider for plaintext files.
The provider expects the headers to be in certain format:

    H1:
        1.  SYSTEM OVERVIEW
        ===================

    H2:
        1.1  PRE-FLIGHT CHECKLIST
        -------------------------

End of document marker:
    [END OF DOCUMENT]

A ./sample-plaintext-doc.txt following the conventions is available in the
repository.


2.  INSTALLATION
================


2.1  INSTALL THE PLAINTEXT PROVIDER PLUGIN
------------------------------------------

Using nvim native packages:

    % mkdir -p ~/.local/share/nvim/site/pack/plugins/start/
    % cd ~/.local/share/nvim/site/pack/plugins/start/
    % git clone https://github.com/subhadig/outline-plaintext-provider.nvim.git


2.2  CONFIGURE OUTLINE.NVIM
---------------------------

    require("outline").setup({
        providers = {
            priority = { 'lsp', 'coc', 'markdown', 'norg', 'man', 'plaintext' },
            lsp = {
                blacklist_clients = {},
            },
            markdown = {
                filetypes = { 'markdown' },
            },
            plaintext = {
                filetypes = { 'text' },
            }
        }
    })


3.  LICENSE
===========

MIT License

Copyright (c) 2026 Subhadip Ghosh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


4.  REFERENCES
==============

    [1] Outline.nvim:
        https://github.com/hedyhli/outline.nvim


--------------------------------------------------------------------------------
[END OF DOCUMENT]
