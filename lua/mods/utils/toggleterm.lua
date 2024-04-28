return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        {
            "<leader>-",
            mode = { "n" },
            "<cmd>ToggleTerm size=40 direction=float<CR>",
            desc = "Toogle terminal window",
        },
    },
    init = function()
        require("toggleterm").setup({})
    end,
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal

        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                border = "double",
            },
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(
                    term.bufnr,
                    "n",
                    "q",
                    "<cmd>close<CR>",
                    { noremap = true, silent = true }
                )
            end,
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        vim.api.nvim_set_keymap(
            "n",
            "<leader>g",
            "<cmd>lua _lazygit_toggle()<CR>",
            { noremap = true, silent = true }
        )
    end,
}
