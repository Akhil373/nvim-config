return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local get_active_lsp = function()
			local msg = "No active LSP"
			local buf_ft = vim.api.nvim_get_option_value("filetype", {})
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if next(clients) == nil then
				return msg
			end

			for _, client in ipairs(clients) do
				local filetypes = client.config.filetypes
				if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
					return "  " .. client.name
				end
			end
			return msg
		end

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "gruvbox-material",
				always_divide_middle = true,
			},
			sections = {
				lualine_x = {
					{
						get_active_lsp,
						cond = function()
							return #vim.lsp.get_clients({ bufnr = 0 }) > 0
						end,
					},
				},
			},
		})
	end,
}
