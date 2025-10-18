return {
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter", -- load the plugin when entering insert mode
		dependencies = {
			"copilotlsp-nvim/copilot-lsp",
		},
		enabled = true,
		config = function()
			require("copilot").setup({
				panel = {
					enabled = false,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- | top | left | right | horizontal | vertical
						ratio = 0.4,
					},
				},
				nes = {
					enabled = true,
					keymap = {
						accept_and_goto = "<leader>p",
						accept = false,
						dismiss = "<Esc>",
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = false,
					hide_during_completion = true,
					debounce = 75,
					keymap = {
						accept = "<C-j>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = true,
					markdown = true,
					help = false,
					gitcommit = true,
					gitrebase = true,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},
}
