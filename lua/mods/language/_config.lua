-- Define LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
        end, opts)
    end,
})

-- Blade Language
--
-- Define an autocmd group for the blade workaround
local augroup = vim.api.nvim_create_augroup("lsp_blade_workaround", { clear = true })

-- Autocommand to temporarily change 'blade' filetype to 'php' when opening for LSP server activation
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = "*.blade.php",
    callback = function()
        vim.bo.filetype = "php"
    end,
})

-- Additional autocommand to switch back to 'blade' after LSP has attached
vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*.blade.php",
    callback = function(args)
        vim.schedule(function()
            -- Check if the attached client is 'intelephense'
            for _, client in ipairs(vim.lsp.get_active_clients()) do
                if client.name == "intelephense" and client.attached_buffers[args.buf] then
                    vim.api.nvim_buf_set_option(args.buf, "filetype", "blade")
                    -- update treesitter parser to blade
                    vim.api.nvim_buf_set_option(args.buf, "syntax", "blade")
                    break
                end
            end
        end)
    end,
})

vim.api.nvim_exec(
    [[
autocmd FileType php set iskeyword+=$
autocmd FileType php setlocal commentstring=//\ %s
]],
    false
)

-- Return empty

return {}
