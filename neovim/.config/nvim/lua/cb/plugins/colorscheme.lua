return {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('nordic').load()
    end
}
-- return {
-- 	"craftzdog/solarized-osaka.nvim",
-- 	init = function()
-- 		vim.cmd.colorscheme 'solarized-osaka-moon'
-- 	end,
--
-- }

	-- { 'mhartington/oceanic-next' },
	--
	-- { "rose-pine/neovim", name = "rose-pine" },
	--
	-- {
	-- 	'AlexvZyl/nordic.nvim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require('nordic').load()
	-- 	end
	-- },
	--
