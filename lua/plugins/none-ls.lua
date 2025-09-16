return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        local null_ls = require("null-ls")
        local sources = {
            require("none-ls.formatting.ruff").with {
                extra_args = { "--extend-select", "I" },
            },
            require("none-ls.formatting.ruff_format"),
            null_ls.builtins.formatting.prettier.with {
                filetypes = { "json", "yaml", "markdown" },
            },
            -- example: clang-format with custom args
            null_ls.builtins.formatting.clang_format.with {
                args = { "-i", "--style=Google" },
            },
            null_ls.builtins.formatting.stylua,
        }

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = sources,

            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false, bufnr = bufnr })
                        end,
                    })
                end

                -- keymap for formatting (buffer-local)
                vim.keymap.set("n", "<A-S-f>", function()
                    vim.lsp.buf.format({ async = true })
                end, { buffer = bufnr })
            end,
        })
    end,
}

