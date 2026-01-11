return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = {
			char = "╷",
			highlight = { "IndentGray" },
		},
		scope = {
			char = "│",
			highlight = { "IndentGray" },
			exclude = {
				language = { "lua" },
			},
		},
		whitespace = {
			highlight = { "Whitespace", "NonText" },
		},
		debounce = 100,
	},
	config = function(_, opts)
		vim.api.nvim_set_hl(0, "IndentGray", { fg = "#808080" })
		require("ibl").setup(opts)
	end,
}
