--- Filename: lsp.lua
-- Description: setup for language LSPs, linter, etc.

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        --- LSP manager
        'mason-org/mason.nvim',
        'mason-org/mason-lspconfig.nvim',
        { 'folke/lazydev.nvim', ft = 'lua' },
    },
}
