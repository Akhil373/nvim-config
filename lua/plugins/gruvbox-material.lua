return {
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
}
