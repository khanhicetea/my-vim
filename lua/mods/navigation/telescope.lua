return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        build = "make",
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        },
        keys = {
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)" },
            { "<leader>o", "<cmd>Telescope oldfiles<cr>",  desc = "Find Old Files" },
            { "<leader>p", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
            {
                "<leader>t",
                function()
                    require("telescope.builtin").lsp_document_symbols()
                end,
                desc = "Find Symbols in document",
            },
            {
                "<leader>d",
                function()
                    require("telescope.builtin").diagnostics({ bufnr = 0 })
                end,
                desc = "Show diagnostics in current buffer",
            },
            {
                "<leader>q",
                function()
                    require("telescope.builtin").quickfix()
                end,
                desc = "Show quickfix in current buffer",
            },
            {
                "gr",
                function()
                    require("telescope.builtin").lsp_references()
                end,
                desc = "Show lsp_references",
            },
        },
    }
}
