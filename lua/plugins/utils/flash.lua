return {
	"folke/flash.nvim",
	event = "VeryLazy",
    enabled = true,
	opts = {},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},

		-- Map `F` to Flash's Treesitter functionality
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},

		-- Map `r` and `R` for remote and treesitter search
		-- {
		-- 	"r",
		-- 	mode = "o",
		-- 	function()
		-- 		require("flash").remote()
		-- 	end,
		-- 	desc = "Remote Flash",
		-- },
		-- {
		-- 	"R",
		-- 	mode = { "o", "x" },
		-- 	function()
		-- 		require("flash").treesitter_search()
		-- 	end,
		-- 	desc = "Treesitter Search",
		-- },

		-- Map `<c-s>` to toggle Flash in the command mode
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
		modes = {
			char = {
				jump_labels = false,
			},
		},
	},
}
