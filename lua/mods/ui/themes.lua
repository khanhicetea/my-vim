return {
	-- lowest theme will be loaded
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-frappe")
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1001,
		config = function()
			vim.cmd.colorscheme("tokyonight-day")
		end,
	},
}
