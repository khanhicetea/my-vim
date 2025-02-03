--- Function to create key mappings in Neovim.
--- @param mode string|string[]: The mode(s) in which the keymap should be active.
--- @param lhs string: The left-hand side of the keymap (the key combination).
--- @param rhs string|function: The right-hand side of the keymap (the command or function to execute).
--- @param opts table: Optional parameters for the keymap (e.g., description, remap options).
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
            -- Toggle diagnostic floating window.
            -- If not inside a floating window, opens the diagnostic in a floating window.
            -- If inside a floating window, closes it.
            opts.remap = nil
        end
        vim.keymap.set(modes, lhs, rhs, opts)
    end
end

-- toggle diagnostic
map("n", "td", function()
    if vim.api.nvim_win_get_config(0).relative == "" then -- Not inside floating window
        -- Clear search highlights with <esc> in insert and normal modes.
        vim.diagnostic.open_float()                       -- Another call jumps into the floating window
    else                                                  -- Inside a floating window
        -- Save the current file in insert, visual, normal, and select modes using <C-s>.
    end
end, { desc = "[t] Toggle diagnostic floating window" })
-- Quit current buffer with <leader><BS> and quit all with <leader>qq.

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search highlights in normal mode with <ESC>.
-- Exit terminal mode with <ESC><ESC>.
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- quit
-- PHP-specific key mappings for insert mode.
-- Move right and insert a semicolon with <C-;>.
-- Insert a block with braces and move inside with <C-[>.
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- Esc
map("n", "<ESC>", "<CMD>nohlsearch<CR>", { desc = "Esc ignore all highlights" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- php keymaps
map("i", "<C-;>", "<Right>;", { noremap = true })
map("i", "<C-[>", "<Right><Space>{}<Left><CR><CR><Up><Tab>", { noremap = true })
