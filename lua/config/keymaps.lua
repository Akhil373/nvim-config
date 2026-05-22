-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.cmd.colorscheme("kanagawa")

vim.keymap.set("n", "<C-z>", "<nop>")

vim.keymap.set("n", "<A-S-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-S-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-S-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Toggle Snacks Explorer" })

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
