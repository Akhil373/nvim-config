-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.cmd.colorscheme("kanagawa")

vim.keymap.set("n", "<C-z>", "<nop>")

vim.keymap.set("n", "<A-S-Down>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "move current line down" })
vim.keymap.set("n", "<A-S-Up>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "move current line up" })
vim.keymap.set(
	"v",
	"<A-S-Down>",
	":m '>+1<CR>gv=gv",
	{ noremap = true, silent = true, desc = "move selected block down" }
)
vim.keymap.set("v", "<A-S-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "move selected block up" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "gl", vim.diagnostic.open_float, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "Toggle Snacks Explorer" })

vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- molten-nvim keymaps
vim.keymap.set("n", "<leader>ip", function()
	local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
	if venv ~= nil then
		venv = string.match(venv, "/.+/(.+)")
		vim.cmd(("MoltenInit %s"):format(venv))
	else
		vim.cmd("MoltenInit python3")
	end
end, { desc = "Initialize Molten for python3", silent = true })
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
-- vim.keymap.set("n", "<leader>e", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
vim.keymap.set(
	"v",
	"<leader>r",
	":<C-u>MoltenEvaluateVisual<CR>gv",
	{ silent = true, desc = "evaluate visual selection" }
)
vim.keymap.set("n", "<leader>rd", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })
vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })

vim.keymap.set("n", "<space>rc", function()
	-- 1. Search backwards for the cell delimiter.
	local start_line = vim.fn.search("^# %%", "bcnW")
	if start_line == 0 then
		start_line = 1
	else
		start_line = start_line + 1
	end

	-- 2. Search forwards for the next cell delimiter.
	local end_line = vim.fn.search("^# %%", "nW")
	if end_line == 0 then
		end_line = vim.api.nvim_buf_line_count(0)
	else
		end_line = end_line - 1
	end

	-- Prevent errors if the start line is below the end line
	if start_line > end_line then
		return
	end

	-- 3. Enter visual line mode and select the block
	vim.api.nvim_win_set_cursor(0, { start_line, 0 })
	vim.cmd("normal! V")
	vim.api.nvim_win_set_cursor(0, { end_line, 0 })

	-- 4. Escape visual mode synchronously to lock the '< and '> marks
	local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
	vim.api.nvim_feedkeys(esc, "x", false)

	-- 5. Call the Molten command without a range
	vim.cmd("MoltenEvaluateVisual")
end, { desc = "Molten: Evaluate Current Cell" })
