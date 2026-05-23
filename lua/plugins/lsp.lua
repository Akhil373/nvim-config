return {
	{
		"mason-org/mason.nvim",
		config = true,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			ensure_installed = {
				"lua_ls",
				"vtsls",
				"ruff",
				"clangd",
				"gopls",
				"pyrefly",
			},
			automatic_installation = false,
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason-lspconfig.nvim" },
		config = function()
			local pyrefly_path = vim.fn.exepath("pyrefly")
			local ruff_path = vim.fn.exepath("ruff")

			-- Global UI settings for diagnostics
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			})

			local server_settings = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
						},
					},
				},

				clangd = {
					cmd = {
						"clangd",
						"--compile-commands-dir=.",
						"--header-insertion=never",
					},
				},

				ruff = {
					cmd = {
						ruff_path ~= "" and ruff_path or "ruff",
						"server",
					},
				},

				pyrefly = {
					cmd = {
						pyrefly_path ~= "" and pyrefly_path or "pyrefly",
						"lsp",
					},
					filetypes = { "python" },
					root_markers = { "pyrefly.toml", "pyproject.toml", "setup.py", ".git" },
				},

				gopls = {},
				vtsls = {},
			}

			for server, config in pairs(server_settings) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
}
