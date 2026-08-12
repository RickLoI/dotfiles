local noice = require('noice')
noice.setup({
    cmdline = {
        format = {
            help = { icon = '' },
        }
    },
    messages = {
        view_hystory = false
    },
    lsp = {
        hover = { silent = true },
        signature = { enabled = false },
        presets = {
            command_palette = true,
            lsp_doc_border = true
        }
    },
    views = {
        mini = {
            win_options = {
                winblend = 0,
                winhighlight = {}
            }
        }
    },
})

