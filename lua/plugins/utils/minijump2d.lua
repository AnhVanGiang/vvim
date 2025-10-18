return {
	"nvim-mini/mini.jump2d",
    enabled = false,
	version = "*",
	config = function()
		require("mini.jump2d").setup({
			mappings = {
				start_jumping = "gw",
			},
			allowed_lines = {
				blank = false, -- Blank line (not sent to spotter even if `true`)
				cursor_before = true, -- Lines before cursor line
				cursor_at = true, -- Cursor line
				cursor_after = true, -- Lines after cursor line
				fold = true, -- Start of fold (not sent to spotter even if `true`)
			},
			view = {
				-- Whether to dim lines with at least one jump spot
				dim = false,

				-- How many steps ahead to show. Set to big number to show all steps.
				n_steps_ahead = 0,
			},
		})
	end,
}
