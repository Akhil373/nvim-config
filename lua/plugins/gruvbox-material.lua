return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		vim.g.gruvbox_material_enable_italic = true
		vim.g.gruvbox_material_background = "soft"
		vim.g.gruvbox_material_foreground = "mix"
		vim.g.gruvbox_material_enable_bold = 1
		vim.g.gruvbox_material_cursor = "green"
		vim.g.gruvbox_material_visual = "green background"
		vim.g.gruvbox_material_float_style = "dim"
		vim.cmd.colorscheme("gruvbox-material")
	end,
}
