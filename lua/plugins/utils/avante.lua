return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	enabled = false,
	lazy = true,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		provider = "gemini",
		providers = {
			gemini = {
				endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
				model = "gemini-2.5-flash", -- Gemini 2.5 Pro model
				timeout = 30000, -- timeout in milliseconds
				temperature = 0, -- adjust if needed
				max_tokens = 100000,
				-- api_key_name = "Gemini_API_key", -- environment variable name (default)
			},
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o-mini", -- GPT-4.1 mini model
				timeout = 30000, -- timeout in milliseconds
				max_tokens = 100000,
				-- api_key_name = "OPENAI_API_KEY", -- environment variable name (default)
				extra_request_body = {
					temperature = 0, -- moved from direct config to extra_request_body
				},
			},
		},
		behaviour = {
			auto_suggestions = true, -- Experimental stage
			auto_set_highlight_group = false,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
			enable_token_counting = true, -- Whether to enable token counting
			enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		-- {
		-- 	-- support for image pasting
		-- 	"HakonHarnes/img-clip.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		-- recommended settings for img-clip
		-- 		default = {
		-- 			embed_image_as_base64 = false,
		-- 			prompt_for_file_name = false,
		-- 			drag_and_drop = {
		-- 				insert_mode = true,
		-- 			},
		-- 			-- required for Windows users
		-- 			use_absolute_path = true,
		-- 		},
		-- 	},
		-- },
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
