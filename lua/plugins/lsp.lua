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
				"ty",
			},
			automatic_installation = false,
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason-lspconfig.nvim" },
		config = function()
			local ty_path = vim.fn.exepath("ty")
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

				ty = {
					cmd = {
						ty_path ~= "" and ty_path or "ty",
						"server",
					},
					filetypes = { "python" },
					root_markers = { "pyproject.toml", "setup.py", ".git" },
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
