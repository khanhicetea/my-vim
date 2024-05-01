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
				"blade-formatter",
				"cssls",
				"emmet_ls",
				"html",
				"intelephense",
				"pint",
				"prettierd",
				"shfmt",
				"sqlls",
				"stylua",
				"twiggy_language_server",
				"tsserver",
				"volar",
				"yamlls",
				"markdown_oxide",
				"bashls",
				"jsonls",
				"tailwindcss",
			},
		})

		local mason_registry = require("mason-registry")

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
			["tsserver"] = function()
				-- Hybrid mode
				local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
					.. "/node_modules/@vue/language-server"

				require("lspconfig")["tsserver"].setup({
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								location = vue_language_server_path,
								languages = { "vue" },
								-- configNamespace = "typescript",
								-- enableForWorkspaceTypeScriptVersions = true,
							},
						},
					},
					filetypes = {
						"typescript",
						"javascript",
						"javascriptreact",
						"typescriptreact",
						"vue",
					},
				})
			end,
			["tailwindcss"] = function()
				require("lspconfig")["tailwindcss"].setup({
					settings = {
						tailwindCSS = {
							experimental = {
								classRegex = {
									"@?class\\(([^]*)\\)",
									"'([^']*)'",
								},
							},
						},
					},
				})
			end,
		})
	end,
}
