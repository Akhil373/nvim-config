return {
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft, {
			python = { "ruff" },
		})
		-- auto-lint on save/enter
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
