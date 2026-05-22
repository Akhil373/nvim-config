return {
	"Vigemus/iron.nvim",
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		local common = require("iron.fts.common")

		-- 1. Initialize a global variable to store the selected path
		vim.g.iron_python_cmd = vim.g.iron_python_cmd or "ipython"

		-- 2. Create a user command to dynamically select the environment
		vim.api.nvim_create_user_command("SelectIpythonEnv", function()
			-- Define standard paths to check
			local paths = {
				vim.fn.expand("~/mlenv/bin/ipython"),
				vim.fn.getcwd() .. "/.venv/bin/ipython",
				vim.fn.getcwd() .. "/venv/bin/ipython",
				"ipython", -- System default fallback
			}

			-- Prioritize the currently active shell virtual environment (if any)
			if vim.env.VIRTUAL_ENV then
				table.insert(paths, 1, vim.env.VIRTUAL_ENV .. "/bin/ipython")
			end

			-- Filter for valid executables and remove duplicates
			local valid_paths, seen = {}, {}
			for _, p in ipairs(paths) do
				if vim.fn.executable(p) == 1 and not seen[p] then
					table.insert(valid_paths, p)
					seen[p] = true
				end
			end

			-- Trigger Neovim's selection UI
			vim.ui.select(valid_paths, { prompt = "Select IPython Environment for Iron:" }, function(choice)
				if choice then
					vim.g.iron_python_cmd = choice
					print("Iron.nvim IPython path set to: " .. choice)
				end
			end)
		end, { desc = "Select Python environment for Iron REPL" })

		iron.setup({
			config = {
				scratch_repl = true,
				repl_definition = {
					python = {
						-- 3. Evaluate the command dynamically when the REPL starts
						command = function()
							return { vim.g.iron_python_cmd, "--no-autoindent" }
						end,
						format = common.bracketed_paste_python,
						block_dividers = { "# %%", "#%%" },
					},
				},
				repl_open_cmd = view.split.vertical.botright(0.40),
			},
			keymaps = {
				toggle_repl = "<space>rr",
				restart_repl = "<space>rR",
				send_motion = "<space>sc",
				visual_send = "<space>sc",
				send_line = "<space>sl",
				send_code_block = "<space>sb",
				send_code_block_and_move = "<space>sn",
				interrupt = "<space>s<space>",
				clear = "<space>cl",
			},
			ignore_blank_lines = true,
		})
	end,
}
