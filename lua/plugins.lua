-- Bootstrap Lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Run setup
require("lazy").setup({
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin-mocha"
        end
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        build = 'make',
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            }
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
                desc = "Goto Symbol",
            }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
        },
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts = {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "bash", "diff", "html", "javascript", "jsdoc", "json", "jsonc",
                "lua", "luadoc", "luap", "markdown", "markdown_inline", "python",
                "query", "regex", "toml", "tsx", "typescript",
                "vim", "vimdoc", "xml", "yaml", "php"
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", },
            { "williamboman/mason-lspconfig.nvim" }
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup()

            require("mason-lspconfig").setup_handlers {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {}
                end,
                ["intelephense"] = function()
                    require("lspconfig")["intelephense"].setup {
                        init_options = {
                            licenceKey = os.getenv('INTELEPHENSE_KEY'),
                        },
                        settings = {
                            intelephense = {
                                telemetry = {
                                    enabled = false,
                                },
                                completion = {
                                    fullyQualifyGlobalConstantsAndFunctions = false
                                },
                                phpdoc = {
                                    returnVoid = false,
                                }
                            },
                        }
                    }
                end
            }
        end
    },
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        opts = function()
            local cmp = require("cmp")
            local defaults = require("cmp.config.default")()
            return {
                completion = {
                    completeopt = "menu,menuone,noinsert",
                },
                mapping = cmp.mapping.preset.insert({
                    ["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ["<C-CR>"] = function(fallback)
                        cmp.abort()
                        fallback()
                    end,
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
                sorting = defaults.sorting,
            }
        end,
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        keys = {
            { "<S-h>",      "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev buffer line" },
            { "<S-L>",      "<cmd>BufferLineCycleNext<cr>",   desc = "Next buffer line" },
            { "<Leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffer lines" },
            { "<Leader>bd", "<cmd>bd<cr>",                    desc = "Close current buffer line" },
        },
        init = function()
            require("bufferline").setup {}
        end,
        opts = {
            options = {
                right_mouse_command = function(n)
                    require("mini.bufremove").delete(n, false)
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo-tree",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },
            }
        }
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        init = function()
            require("lualine").setup {}
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        }
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        keys = {
            { "<Leader>e", "<cmd>Neotree filesystem reveal toggle <cr>", desc = "Open Neotree" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        init = function()
            require("gitsigns").setup {}
        end,
    },
    {
        "RRethy/vim-illuminate",
        init = function()
            require("illuminate").configure {}
        end,
    },
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        keys = {
            {
                "<leader>\\",
                mode = { "n" },
                function()
                    require("spectre").toggle()
                end,
                desc = "Search and replace files"
            },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        },
        init = function()
            require("spectre").setup {}
        end,
    }
})