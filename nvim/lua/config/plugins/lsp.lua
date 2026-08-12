local lazydev = require('lazydev')
lazydev.setup({
    opts = {
        library = {
            path = '{3rd}/luv/library',
            words = { 'vim%s.uv' }
        }
    }
})

local capabilities = require('blink.cmp').get_lsp_capabilities()
local mason = require('mason')
mason.setup()

local lspconf = require('mason-lspconfig')
lspconf.setup({
    automatic_installation = false,
    ensure_installed = { 'lua_ls', 'clangd', 'pylsp', 'qmlls', 'texlab' },
    handler = {
        --- Default handler
        function(server)
            vim.lsp.config(server, { capabilities = capabilities })
        end,

        --- TEXLAB
        vim.lsp.config('texlab', {
            capabilities = capabilities,
            settings = {
                ['texlab'] = {
                    build = {
                        executable = 'latexmk',
                        args = {
                            '-auxdir=/tmp/',
                            '-bibtex-cond',
                            '-pdflua',
                            '-interaction=nonstopmode',
                            '-synctex=1',
                            '-shell-escape',
                            '%f'
                        },
                        forwardSearchAfter = true,
                    },
                    forwardSearch = {
                        executable = 'zathura',
                        args = {
                            '--synctex-forward',
                            '%l:1:%f',
                            '%p',
                        }
                    },
                },
            },
        }),

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    workspace = {
                        library = { 
                            '/usr/share/hypr/stubs'
                        }
                    },
                    diagnostic = {
                        globals = { 'hl' }
                    }
                }
            }
        }),

        --- QMLLS
        vim.lsp.config('qmlls', {
            cmd = { 'qmlls6' },
            filetype = { 'qml' },
            root_markers = { '.git', '*.qml' }
        }),

        vim.lsp.enable('qmlls')
    }
})
