return {
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			vim.g.barbar_auto_setup = false
			require("barbar").setup({
				animation = true,
				tabpages = true,
				clickable = true,
				focus_on_close = "left",
				highlight_visible = true,
				icons = {
					filetype = { enabled = false },
				},
			})
			vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
			vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
			vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
			vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
			vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
			vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
			vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
			vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
			vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
			vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
			vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
			vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
			vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
		end,
	},
}
