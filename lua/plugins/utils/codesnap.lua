return {
	"mistricky/codesnap.nvim",
	build = "make",
	-- Load lazily to prevent cpath pollution that breaks blink.cmp
	lazy = true,
	cmd = { "CodeSnap", "CodeSnapSave", "CodeSnapHighlight", "CodeSnapASCII" },
	opts = {
		save_path = "~/Pictures",
	},
}
