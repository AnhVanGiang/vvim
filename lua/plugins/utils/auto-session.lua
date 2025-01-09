return {
	"rmagatti/auto-session",
	enabled = true,
	config = function()
		require("auto-session").setup({
			log_level = "info", -- Set logging level
			suppressed_dirs = { "~/", "~/Projects" }, -- Directories to ignore
			auto_save = true,
			enabled = true,
			auto_restore = true,
			lazy_support = true,
			continue_restore_on_error = true,
		})
	end,
}
