function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

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
            {
                "<leader>/",
                function()
                    local text = vim.getVisualSelection()
                    require('telescope.builtin').live_grep({ default_text = text })
                end,
                desc = "Grep selected",
                mode = { "v" }
            },
            { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Grep (Root Dir)", mode = { "n" } },
            { "<leader>o", "<cmd>Telescope oldfiles<cr>",  desc = "Find Old Files" },
            {
                "<leader>f",
                function()
                    local text = vim.getVisualSelection()
                    text = text:gsub("[^%w]", " ")
                    require('telescope.builtin').git_files({ default_text = text })
                end,
                desc = "Find Git Files",
                mode = { "v" }
            },
            { "<leader>f", "<cmd>Telescope git_files<cr>", desc = "Find Git Files", mode = { "n" } },
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
