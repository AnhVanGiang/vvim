return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	enabled = true,
	lazy = true,
	version = false, -- set this if you want to always pull the latest change
	opts = {
		-- add any opts here
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
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			-- opts = {
			-- 	-- recommended settings
				provider = "gemini",
				openai = {
					endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
					model = "gemini-2.5-flash-preview-04-17", -- your desired model (or use gpt-4o, etc.)
					timeout = 30000, -- timeout in milliseconds
					temperature = 0, -- adjust if needed
					max_tokens = 100000,
					-- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
				},
			-- 	behaviour = {
			-- 		auto_suggestions = true, -- Experimental stage
			-- 		auto_set_highlight_group = false,
			-- 		auto_set_keymaps = true,
			-- 		auto_apply_diff_after_generation = false,
			-- 		support_paste_from_clipboard = false,
			-- 		minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
			-- 		enable_token_counting = true, -- Whether to enable token counting. Default to true.
			-- 		enable_cursor_planning_mode = true, -- Whether to enable Cursor Planning Mode. Default to false.
			-- 	},
			-- 	default = {
			-- 		embed_image_as_base64 = false,
			-- 		prompt_for_file_name = false,
			-- 		drag_and_drop = {
			-- 			insert_mode = true,
			-- 		},
			-- 		-- required for Windows users
			-- 		use_absolute_path = true,
			-- 	},
			-- },
		},
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
