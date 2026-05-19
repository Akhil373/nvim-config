return {
	{
		"folke/snacks.nvim",
		opts = {
			statuscolumn = {
				enabled = true,
				left = { "mark", "sign" },
				right = { "fold", "git" },
			},
			picker = {
				sources = {
					explorer = {
						hidden = true,
						ignored = true,
					},
					files = {
						hidden = true,
						ignored = true,
					},
				},
			},
		},
	},
}
