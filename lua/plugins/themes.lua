return {
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_transparent_background = 0
			vim.api.nvim_set_hl(0, "Normal", { bg = "#282829", ctermbg = 235 })

			vim.opt.background = "dark"

			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{ "scottmckendry/cyberdream.nvim", lazy = false, priority = 1000 },

	{
		"navarasu/onedark.nvim",
		version = "v0.1.0", -- Pin to legacy version
		priority = 1000,
		config = function()
			require("onedark").setup({
				style = "deep",
			})
			require("onedark").load()
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		theme = "wave", -- Load "wave" theme
		background = {
			dark = "dragon",
			light = "lotus",
		},
	},
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.everforest_background = "hard"
			vim.g.everforest_enable_italic = true
			vim.cmd.colorscheme("everforest")
		end,
	},
}
