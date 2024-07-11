return {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<Leader>e", "<cmd>NvimTreeToggle <cr>", desc = "Open nvim-tree" },
    },
    config = function()
        require("nvim-tree").setup {}
    end,
}
