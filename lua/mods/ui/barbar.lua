return {
    "romgrk/barbar.nvim",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<C-h>",      "<cmd>BufferPrevious<cr>",           desc = "Prev buffer line" },
        { "<C-l>",      "<cmd>BufferNext<cr>",               desc = "Next buffer line" },
        { "<Leader>bo", "<cmd>BufferCloseAllButCurrent<cr>", desc = "Close other buffer lines" },
        { "<Leader>bd", "<cmd>BufferClose<cr>",              desc = "Close current buffer line" },
    },
    init = function()
        require("barbar").setup({})
    end,
}
