return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	opts = {
		filesystem = {
			follow_current_file = {
				enabled = true,
			},
		},
	},
	keys = {
		{ "<Leader>e", "<cmd>Neotree filesystem reveal toggle <cr>", desc = "Open Neotree" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
}
