-- Map <leader> key to SPACE
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)


-- Settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true


-- Setup lazy.nvim

local opts = {}

require("lazy").setup("plugins")
local builtin = require('telescope.builtin')
local config = require("nvim-treesitter.configs")
local ts_install = {"nvim-treesitter.install"}
ts_install.compilers = {"zig"}

config.setup ({
    ensure_installed = { "lua", "c", "cpp", "markdown", "javascript", "python", "go", "markdown_inline", "vim", "vimdoc", "query", "rust", "jinja", "json", "typescript", "yaml", "html" },
    highlight = { enable = true },
    indent = { enable = true }
})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>')
