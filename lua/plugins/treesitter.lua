return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		local ts_install = { "nvim-treesitter.install" }
		ts_install.compilers = { "zig" }
		config.setup({
			auto_install = true,
			ensure_installed = { "lua" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
