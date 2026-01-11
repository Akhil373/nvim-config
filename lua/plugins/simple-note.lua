return {
	"rguruprakash/simple-note.nvim",
	config = function()
		require("simple-note").setup({
			notes_dir = "~/notes/",
		})
	end,
}
