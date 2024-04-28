return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup()

        require("mason-lspconfig").setup_handlers({
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup({})
            end,
            ["intelephense"] = function()
                require("lspconfig")["intelephense"].setup({
                    init_options = {
                        licenceKey = os.getenv("INTELEPHENSE_KEY"),
                    },
                    settings = {
                        intelephense = {
                            filetypes = { "php", "blade" },
                            files = {
                                associations = { "*.php", "*.blade.php" }, -- Associating .blade.php files as well
                                maxSize = 5000000,
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
        })
    end,
}
