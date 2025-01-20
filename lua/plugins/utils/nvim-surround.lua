return {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>H",
				normal = "ys",
				normal_cur = "yss",
				normal_line = "yH",
				normal_cur_line = "yHS",
				visual = "H",
				visual_line = "gH",
				delete = "ds",
				change = "cs",
				change_line = "cH",
			},
		})
	end,
}
