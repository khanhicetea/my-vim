return {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
        {
            "<leader>\\",
            mode = { "n" },
            function()
                require("spectre").toggle()
            end,
            desc = "Search and replace files",
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
    init = function()
        require("spectre").setup({})
    end,
}
