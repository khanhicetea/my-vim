return {
	-- lowest theme will be loaded
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1001,
		config = function()
			vim.cmd.colorscheme("catppuccin-latte")
		end,
	},
}
