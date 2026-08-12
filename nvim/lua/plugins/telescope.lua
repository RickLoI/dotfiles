return {
    'nvim-telescope/telescope.nvim',
    name = 'telescope',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
}
