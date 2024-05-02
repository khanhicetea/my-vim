return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		search = {
			multi_window = false,
			forward = false,
		},
		jump = {
			autojump = true,
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
	},
}
