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
			close_if_last_window = true,
			enable_git_status = true,
			window = {
				position = "right",
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
				},
			},
			-- event_handlers = {
			-- 	{
			-- 		event = "file_opened",
			-- 		handler = function()
			-- 			require("neo-tree").close_all()
			-- 			require("neo-tree.command").execute({
			-- 				action = "focus",
			-- 				source = "buffers",
			-- 				position = "right",
			-- 			})
			-- 		end,
			-- 	},
			-- },
			git_status = {
				symbols = {
					added = "",
					modified = "",
					deleted = "✖",
					renamed = "󰁕",
					untracked = "",
					ignored = "",
					unstaged = "󰄱",
					staged = "",
					conflict = "",
				},
			},
		})
		vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")
		vim.keymap.set("n", "<C-a>", ":Neotree action=focus<CR>")
	end,
}
