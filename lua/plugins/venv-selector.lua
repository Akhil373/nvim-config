return {
	"linux-cultist/venv-selector.nvim",
	ft = "python",
	keys = {
		{ ",v", "<cmd>VenvSelect<cr>" },
	},
	opts = {
		search = {
			cwd = {
				command = "fd '/bin/python$' ~/mlenv/ --full-path --color never",
			},
		},
		options = {
			debug = true,
		},
	},
}
