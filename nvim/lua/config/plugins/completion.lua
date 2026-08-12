local blink = require('blink.cmp')
blink.setup({
    cmdline = { enabled = false },

    sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100,
            },
            omni = {
                opts = { omnifunc = 'vimtex#complete#omnifunc', },
            },
            lsp = {
                name = 'LSP',
                module = 'blink.cmp.sources.lsp',
                transform_items = function(_, items)
                    return vim.tbl_filter(function(item)
                        local kind = item.kind
                        local blinkTypes = require('blink.cmp.types').CompletionItemKind

                        if item.source_name == 'LSP' and item.client_name == 'texlab' then
                            return kind ~= blinkTypes.File and kind ~= blinkTypes.Folder
                        end

                        return true
                    end, items)
                end
            }
        },
    },

    snippets = { preset = 'luasnip' },

    keymap = {
        preset = 'none',
        ['<C-space>'] = { 'show' },
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Tab>'] = { 'select_next', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'fallback' }
    },

    completion = {
        accept = {
            auto_brackets = {
                kind_resolution = {
                    enabled = true,
                    blocked_filetypes = { 'tex', 'plaintex' },
                }
            }
        },

        documentation = { auto_show = true, auto_show_delay_ms = 0 },
        trigger = { show_on_keyword = true }
    },

    appearance = { nerd_font_variant = 'mono' },
    fuzzy = { implementation = 'prefer_rust' },
    signature = { enabled = true }
})
