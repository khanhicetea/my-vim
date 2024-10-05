-- local logger = require("plenary.log").new({ plugin = "my_plugin", level = "info", use_console = "sync" })
return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "cssls",
                -- "emmet_ls",
                "lua_ls",
                "html",
                "intelephense",
                "sqlls",
                "twiggy_language_server",
                "ts_ls",
                -- "volar",
                "yamlls",
                "markdown_oxide",
                "bashls",
                "jsonls",
                "tailwindcss",
            },
        })

        require("mason-lspconfig").setup_handlers({
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup({})
            end,
            ["lua_ls"] = function()
                require("lspconfig")["lua_ls"].setup({
                    settings = {
                        Lua = {
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                }
                            },
                            hint = { enable = true },
                        }
                    }
                })
            end,
            ["intelephense"] = function()
                local intelephense_key = os.getenv("INTELEPHENSE_KEY")

                require("lspconfig")["intelephense"].setup({
                    init_options = {
                        licenceKey = intelephense_key,
                    },
                    settings = {
                        intelephense = {
                            filetypes = { "php", "blade" },
                            files = {
                                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                                maxSize = 5000000,
                                exclude = {
                                    "**/.git/**",
                                    "**/.svn/**",
                                    "**/.hg/**",
                                    "**/CVS/**",
                                    "**/.DS_Store/**",
                                    "**/node_modules/**",
                                    "**/bower_components/**",
                                    "**/vendor/**/{Tests,tests}/**",
                                    "**/.history/**",
                                    "**/vendor/**/vendor/**",
                                    -- "**/packages/**",
                                },
                            },
                            telemetry = {
                                enabled = false,
                            },
                            completion = {
                                fullyQualifyGlobalConstantsAndFunctions = false,
                            },
                            phpdoc = {
                                returnVoid = false,
                            },
                        },
                    },
                })
            end,
            ["ts_ls"] = function()
                require("lspconfig")["ts_ls"].setup({})

                -- Hybrid mode (for Vue)
                -- local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
                --     .. "/node_modules/@vue/language-server"
                --
                -- require("lspconfig")["tsserver"].setup({
                --     init_options = {
                --         plugins = {
                --             {
                --                 name = "@vue/typescript-plugin",
                --                 location = vue_language_server_path,
                --                 languages = { "vue" },
                --                 -- configNamespace = "typescript",
                --                 -- enableForWorkspaceTypeScriptVersions = true,
                --             },
                --         },
                --     },
                --     filetypes = {
                --         "typescript",
                --         "javascript",
                --         "javascriptreact",
                --         "typescriptreact",
                --         "vue",
                --     },
                -- })
            end,
            ["tailwindcss"] = function()
                require("lspconfig")["tailwindcss"].setup({
                    settings = {
                        tailwindCSS = {
                            experimental = {
                                -- for php vdom
                                -- classRegex = {
                                --     "class\\(['\"]([^'\"]*)['\"]\\)",
                                -- },
                            },
                        },
                    },
                })
            end,
        })
    end,
}
