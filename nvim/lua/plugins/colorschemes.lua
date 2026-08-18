return {
    {
        'rose-pine/neovim',
        name = 'rose-pine',
    },
    {
        'folke/tokyonight.nvim',
        name = 'tokyonight'
    },
    {
        'UtsuroNoArashi/haligan.nvim',
        name = 'haligan',
        config = function()
            require('haligan').setup()
            vim.cmd('colorscheme haligan')
        end
    }
}
