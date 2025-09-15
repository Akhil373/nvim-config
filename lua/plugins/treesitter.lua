return {
    "nvim-treesitter/nvim-treesitter", 
    branch = 'master', 
    lazy = false, 
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        local ts_install = {"nvim-treesitter.install"}
        ts_install.compilers = {"zig"}
        config.setup ({
            ensure_installed = { "lua", "c", "cpp", "markdown", "javascript", "python", "go", "markdown_inline", "vim", "vimdoc", "query", "rust", "jinja", "json", "typescript", "yaml", "html" },
            highlight = { enable = true },
            indent = { enable = true }
        })
    end
}
