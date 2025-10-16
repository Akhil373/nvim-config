return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					visible = true, -- show hidden items but dimmed
					hide_dotfiles = false, -- actually show dotfiles
				},
			},
		})
		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")
		vim.keymap.set("n", "<C-a>", ":Neotree action=focus<CR>")
	end,
}
