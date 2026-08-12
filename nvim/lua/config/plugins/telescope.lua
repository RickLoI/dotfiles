local telescope = require('telescope')
telescope.setup({
    defaults = {
        path_display = { 'tail' },
    },
    extentions = { fzf = {} }
})
telescope.load_extension('fzf')
