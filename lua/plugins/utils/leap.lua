return {
	"ggandor/leap.nvim",
    enabled = true,
	dependencies = {
		"tpope/vim-repeat", -- Optional: enables repeating leap motions with .
	},
	config = function()
		require("leap").add_default_mappings()

		-- Optional: Custom configuration
		-- require('leap').opts.highlight_unlabeled_phase_one_targets = true
		-- require('leap').opts.case_sensitive = false
	end,
	keys = {
		{ "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
		{ "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
		{ "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
	},
}
