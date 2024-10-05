return {
    "stevearc/conform.nvim",
    opts = {
        format = {
            timeout_ms = 5000,
            async = false,
            quiet = false,
        },
        format_on_save = {
            timeout_ms = 5000,
            lsp_fallback = true,
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            javascript = { { "prettier" } },
            typescript = { { "prettier" } },
            typescriptreact = { { "prettier" } },
            blade = { "blade-formatter", "rustywind" },
        },
        formatters = {
            injected = { options = { ignore_errors = true } },
            prettier = {
                command = 'prettier',
                args = function()
                    return {
                        '--stdin-filepath', vim.api.nvim_buf_get_name(0),
                        '--trailing-comma', 'es5',  -- Add trailing commas where valid in ES5 (objects, arrays, etc.)
                        '--tab-width', '2',         -- Specify the number of spaces per indentation-level
                        '--print-width', '120',     -- Max length each line
                        '--semi', 'false',          -- Do not add semicolons at the ends of statements
                        '--arrow-parens', 'always', -- Arrow parens
                        -- '--single-quote',              -- Use single quotes instead of double quotes
                        -- '--single-attribute-per-line', -- Do not add semicolons at the ends of statements
                    }
                end,
                stdin = true,
            },
        },
    },
}
