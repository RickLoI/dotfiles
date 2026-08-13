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
            require('haligan').setup({
                groups = {
                    Normal = { fg = 'text', bg = 'NONE' }
                }
            })
            vim.cmd('colorscheme haligan')
        end
    }
}
