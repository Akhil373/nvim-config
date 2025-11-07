return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "gruvbox-material",
				always_divide_middle = true,
			},
		})
	end,
}
