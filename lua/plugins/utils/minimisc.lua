return {
	"nvim-mini/mini.misc",
	version = false,
	keys = {
		{
			"<leader>z",
			function()
				require("mini.misc").zoom()
			end,
			desc = "Toggle Zoom",
		},
	},
}
