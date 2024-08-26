return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            custom_captures = {
                ["javascript"] = "javascript"
            }
        },
        indent = { enable = true },
        ensure_installed = {
            "bash",
            "blade",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "php",
        },
    },
    config = function(_, opts)
        ---@class ParserInfo[]
        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        parser_config.blade = {
            install_info = {
                url = "https://github.com/EmranMR/tree-sitter-blade",
                files = {
                    "src/parser.c",
                },
                branch = "main",
                generate_requires_npm = true,
                requires_generate_from_grammar = true,
            },
            filetype = "blade",
        }

        require("nvim-treesitter.configs").setup(opts)
    end,
}
