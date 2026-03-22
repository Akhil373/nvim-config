return {
	-- mason
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
	},

	-- mason-lspconfig
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls",
				"vtsls",
				"ruff",
				"clangd",
				"gopls",
			},
			automatic_installation = false,
		},
	},

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = true,
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			},
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							workspace = {
								checkThirdParty = false,
							},
						},
					},
				},

				gopls = {},

				clangd = {
					cmd = {
						"clangd",
						"--compile-commands-dir=.",
						"--header-insertion=never",
					},
				},

				ruff = {},
			},
		},
	},
}
