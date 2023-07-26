return {
	'nvim-lua/plenary.nvim',
	'kkharji/sqlite.lua',
	{ 'dstein64/vim-startuptime', cmd = 'StartupTime' },
	-- normal/insert模式切换的输入法记忆
	{ 'h-hg/fcitx.nvim',          event = 'VeryLazy' },
	{ 'wakatime/vim-wakatime',    event = 'VeryLazy' },
	{
		'MiuKaShi/vim-gf-list',
		keys = 'gf',
		config = function()
			vim.g.GfList_map_n_gf = 'gf'
			vim.g.GfList_map_v_gf = 'gf'
		end,
	},
	{ 'junegunn/fzf', build = ':call fzf#install()', event = 'VeryLazy' },
	-- { 'skywind3000/asyncrun.vim', cmd = 'AsyncRun' } -- 异步运行
}
