-- Code linter and formatter
return {
	-- Ensure install for linter and formatter
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		opts = {
			ensure_installed = { "cpplint", "shellcheck", "prettier" },
		},
	},
	-- Linter
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("lint").linters_by_ft = {
				sh = { "shellcheck" },
				c = { "cpplint" },
				cpp = { "cpplint" },
			}

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
	-- Formatter
	{
		"stevearc/conform.nvim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				desc = "LSP/Conform: Format the buffer",
			},
		},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					html = { "prettier" },
					css = { "prettier" },
					json = { "prettier" },
					javascript = { "prettier" },
					markdown = { "prettier" },
					typescript = { "prettier" },
					yaml = { "prettier" },
					python = { "isort", "black", timeout_ms = 30000, "yapf" },
					rust = { "rustfmt" },
					lua = { "stylua" },
					sql = { "sql-formatter", "sqlfluff" },
					toml = { "taplo" },
				},
				formatters = {
					-- black = {
					-- 	prepend_args = { "--fast"}, -- Use Black in fast mode (optional)
					-- },

                    -- [ "sqlfluff" ] = {
                    --     append_args = {"--dialect", "bigquery", "$FILENAME" },
                    -- },
				},
			})
		end,
	},
}
