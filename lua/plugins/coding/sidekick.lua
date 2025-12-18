return {
	"folke/sidekick.nvim",
	opts = {
		cli = {
			watch = true, -- notify Neovim of file changes done by AI CLI tools
			win = {
				wo = {}, ---@type vim.wo
				bo = {}, ---@type vim.bo
				width = 80,
				height = 20,
				layout = "right",
				-- position = "bottom", ---@type "left"|"bottom"|"top"|"right"
				--- CLI Tool Keymaps
				--- default mode is `t`
				---@type table<string, sidekick.cli.Keymap|false>
				keys = {
					-- stopinsert = { "<c-q>", "stopinsert", mode = "t", desc = "enter normal mode" },
					-- hide_n = { "q", "hide", mode = "n" }, -- hide from normal mode
					-- hide_t = { "<c-q>", "hide" }, -- hide from terminal mode
					-- win_p = { "<c-w>p", "blur" }, -- leave the cli window
					-- blur = { "<c-o>", "blur" }, -- leave the cli window
					-- prompt = { "<c-p>", "prompt" }, -- insert prompt or context
					-- {
					-- 	"<Tab>",
					-- 	function()
					-- 		-- if there is a next edit, jump to it, otherwise apply it if any
					-- 		if not require("sidekick").nes_jump_or_apply() then
					-- 			return "<Tab>" -- fallback to normal tab
					-- 		end
					-- 	end,
					-- 	expr = true,
					-- 	desc = "Goto/Apply Next Edit Suggestion",
					-- },
                    -- {
                    --     "<leader>ac",
                    --     function()
                    --         require("sidekick.cli").toggle({ name = "claude", focus = true })
                    --     end,
                    --     desc = "Sidekick Claude Toggle",
                    --     mode = { "n", "v" },
                    -- },
                    -- hide_ctrl_dot = { "<c-.>", "hide"      , mode = "nt", desc = "hide the terminal window" },
					-- example of custom keymap:
					-- say_hi = {
					--   "<c-h>",
					--   function(t)
					--     t:send("hi!")
					--   end,
					-- },
				},
			},
		},
	},
	-- keys = {
	-- {
	--   "<Tab>",
	--   function()
	--     -- if there is a next edit, jump to it, otherwise apply it if any
	--     if not require("sidekick").nes_jump_or_apply() then
	--       return "<Tab>" -- fallback to normal tab
	--     end
	--   end,
	--   expr = true,
	--   desc = "Goto/Apply Next Edit Suggestion",
	-- },
	--   {
	--     "<leader>aa",
	--     function()
	--       require("sidekick.cli").toggle({ focus = true })
	--     end,
	--     desc = "Sidekick Toggle CLI",
	--     mode = { "n", "v" },
	--   },
	-- {
	-- 	"<leader>ac",
	-- 	function()
	-- 		require("sidekick.cli").toggle({ name = "claude", focus = true })
	-- 	end,
	-- 	desc = "Sidekick Claude Toggle",
	-- 	mode = { "n", "v" },
	-- },
	--   {
	--     "<leader>ag",
	--     function()
	--       require("sidekick.cli").toggle({ name = "grok", focus = true })
	--     end,
	--     desc = "Sidekick Grok Toggle",
	--     mode = { "n", "v" },
	--   },
	--   {
	--     "<leader>ap",
	--     function()
	--       require("sidekick.cli").select_prompt()
	--     end,
	--     desc = "Sidekick Ask Prompt",
	--     mode = { "n", "v" },
	--   },
	-- },
}
