-- Code linter and formatter
return {
	-- Ensure install for linter and formatter
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		opts = {
			ensure_installed = { "cpplint", "shellcheck", "prettier", "ruff" },
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
					python = { "ruff_format", "ruff_organize_imports" },
					rust = { "rustfmt" },
					lua = { "stylua" },
					sql = { "sql-formatter", "sqlfluff" },
					toml = { "taplo" },
                    terraform = { "terraform_fmt" },
				},
				formatters = {
					ruff_format = {
						args = { "format", "--line-length", "120", "--stdin-filename", "$FILENAME", "-" },
					},
					ruff_organize_imports = {
						args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
					},

                    -- [ "sqlfluff" ] = {
                    --     append_args = {"--dialect", "bigquery", "$FILENAME" },
                    -- },
				},
			})
		end,
	},
}
