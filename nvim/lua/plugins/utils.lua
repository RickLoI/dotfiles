return {
	{ 'folke/trouble.nvim' },
	{  'mbbill/undotree' },
	{ 'HiPhish/rainbow-delimiters.nvim' },
	{ 
		'nvim-lualine/lualine.nvim', 
		dependencies = 'nvim-tree/nvim-web-devicons'
	},
{
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
}
}
