return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "ruff", "pylsp", "clangd", "gopls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- Define default settings for all servers
			local default_cap = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("*", {
				capabilities = default_cap,
			})

			-- Configure individual servers
			vim.lsp.config("lua_ls", {})
			vim.lsp.config("ts_ls", {})
			vim.lsp.config("gopls", {})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd",
					"--query-driver=C:\\MinGW\\bin",
					"compile-commands-dir=.",
					"--header-insertion=never",
				},
			})

			vim.lsp.config("pylsp", {
				filetypes = { "python" },
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							pylsp_mypy = { enabled = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
						},
					},
				},
			})

			-- Enable all the configured servers
			vim.lsp.enable({ "lua_ls", "ts_ls", "gopls", "clangd", "pylsp" })

			-- Diagnostic settings
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})
		end,
	},
}
