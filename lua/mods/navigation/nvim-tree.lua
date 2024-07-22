return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<Leader>e", "<cmd>NvimTreeToggle <cr>", desc = "Open nvim-tree" },
    },
    init = function()
        require("nvim-tree").setup {
            update_focused_file = {
                enable = true,
                update_cwd = false,
            },
            filters = {
                dotfiles = false,
                exclude = {
                    "vendor", "node_modules",
                },
                custom = { "^\\.git$", "^\\.DS_Store$" },
            }
        }
    end,
}
