return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                go = { "goimports", "gofumpt" },

                json = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },

                lua = { "stylua" },

                python = { "black" },

                c = { "clang-format" },
                cpp = { "clang-format" },

                sh = { "shfmt" },
            },
        },
    },
}
