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

vim.keymap.set("n", "<leader>rc", function()
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

-- jump to next or previous cell in notebooks
vim.keymap.set("n", "[n", function()
	local jump_to = vim.fn.search("^# %%", "nW")
	if jump_to == 0 then
		jump_to = vim.api.nvim_buf_line_count(0)
	end
	local row = vim.api.nvim_win_get_cursor(0)[1]
	if row > jump_to then
		return
	end

	vim.api.nvim_win_set_cursor(0, { jump_to, 0 })
end, { desc = "jump to next notebook cell (# %%)" })

vim.keymap.set("n", "]n", function()
	local jump_to = vim.fn.search("^# %%", "bnW")
	if jump_to == 0 then
		jump_to = 1
	end
	local row = vim.api.nvim_win_get_cursor(0)[1]
	if row < jump_to then
		return
	end

	vim.api.nvim_win_set_cursor(0, { jump_to, 0 })
end, { desc = "jump to prev notebook cell (# %%)" })

-- evaulate all cells below sequentially
vim.keymap.set("n", "<leader>ra", function()
	if #vim.fn.MoltenRunningKernels(true) == 0 then
		vim.notify("Molten: No active kernel detected! Please choose a kernel first.", vim.log.levels.WARN)
		vim.cmd("MoltenInit")
		return
	end

	local delay_ms = 500
	local old_cursor = vim.api.nvim_win_get_cursor(0)

	local function run_next_cell()
		local start_line = vim.fn.search("^# %%", "bcnW")
		if start_line == 0 then
			start_line = 1
		else
			start_line = start_line + 1
		end

		local end_line = vim.fn.search("^# %%", "nW")
		if end_line == 0 then
			end_line = vim.api.nvim_buf_line_count(0)
		else
			end_line = end_line - 1
		end

		-- SAFE SKIP: Only evaluate if the cell contains actual lines of code.
		-- This prevents empty cells or back-to-back markers from crashing the loop.
		if start_line <= end_line then
			vim.api.nvim_win_set_cursor(0, { start_line, 0 })
			vim.cmd("normal! V")
			vim.api.nvim_win_set_cursor(0, { end_line, 0 })

			local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
			vim.api.nvim_feedkeys(esc, "x", false)

			vim.cmd("MoltenEvaluateVisual")
		end

		local next_cell = vim.fn.search("^# %%", "W")

		if next_cell ~= 0 then
			vim.defer_fn(run_next_cell, delay_ms)
		else
			print("Molten: Completed running to end of file!")
		end
	end

	run_next_cell()
end, { desc = "Molten: Run All Cells" })
