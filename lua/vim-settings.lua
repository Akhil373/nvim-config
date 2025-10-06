-- Settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.undotree_DiffCommand = "FC"

vim.opt.guifont = "JetBrains Mono:h17"
vim.opt.number = true

vim.opt.wrap = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"

vim.o.shell = "powershell.exe"
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy Bypass -Command"

vim.opt.scrolloff = 999

vim.opt.virtualedit = "block"

vim.opt.inccommand = "split"

vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.keymap.set("n", "<A-S-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-S-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-S-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

vim.keymap.set("n", "<C-s>", ":w<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle)

vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})
