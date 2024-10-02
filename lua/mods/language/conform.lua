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
        },
    },
}
