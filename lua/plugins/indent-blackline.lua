return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		indent = { char = "╷" },
		whitespace = {
			highlight = { "Whitespace", "NonText" },
		},
		scope = {
			exclude = {
				language = { "lua" },
			},
		},
		debounce = 100,
	},
}
