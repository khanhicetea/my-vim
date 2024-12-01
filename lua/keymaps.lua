-- from lazyvim
local map = function(mode, lhs, rhs, opts)
    local keys = require("lazy.core.handler").handlers.keys
    ---@cast keys LazyKeysHandler
    local modes = type(mode) == "string" and { mode } or mode

    ---@param m string
    modes = vim.tbl_filter(function(m)
        return not (keys.have and keys:have(lhs, m))
    end, modes)

    -- do not create the keymap if a lazy keys handler exists
    if #modes > 0 then
        opts = opts or {}
        opts.silent = opts.silent ~= false
        if opts.remap and not vim.g.vscode then
            ---@diagnostic disable-next-line: no-unknown
            opts.remap = nil
        end
        vim.keymap.set(modes, lhs, rhs, opts)
    end
end

-- toggle diagnostic
map("n", "td", function()
    if vim.api.nvim_win_get_config(0).relative == "" then -- Not inside floating window
        vim.diagnostic.open_float()                       -- Open diagnostic in floating window
        vim.diagnostic.open_float()                       -- Another call jumps into the floating window
    else                                                  -- Inside a floating window
        vim.api.nvim_win_close(0, false)                  -- Or you can press "q" in the floating window
    end
end, { desc = "[t] Toggle diagnostic floating window" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- quit
map("n", "<leader><BS>", "<cmd>bd<cr>", { desc = "Quit current buffer" })
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Esc
map("n", "<ESC>", "<CMD>nohlsearch<CR>")
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- php keymaps
map("i", "<C-;>", "<Right>;", { noremap = true })
map("i", "<C-[>", "<Right><Space>{}<Left><CR><CR><Up><Tab>", { noremap = true })
