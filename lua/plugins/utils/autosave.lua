return {
	"Pocco81/auto-save.nvim",
	enabled = true,
	config = function()
		local auto_save = require("auto-save")

		auto_save.setup({
			enabled = true, -- Start auto-save when the plugin is loaded
			execution_message = {
				message = function()
					return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
				end,
				cleaning_interval = 1000,
			},
			trigger_events = { "InsertLeave" }, -- Auto-save on these events
			condition = function(buf)
				-- Check if the buffer is valid
				if not vim.api.nvim_buf_is_valid(buf) then
					return false
				end

				-- Get the filetype of the buffer
				local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
				if filetype == "harpoon" or filetype == "sql" then
					return false
				end

				-- Get modifiable status of the buffer
				local modifiable = vim.api.nvim_buf_get_option(buf, "modifiable")
				-- Only allow saving if the buffer is modifiable and the filetype is not gitcommit or markdown
				if modifiable and not vim.tbl_contains({ "gitcommit"}, filetype) then
					return true
				end

				return false
			end,
			write_all_buffers = false, -- Save only the current buffer
			debounce_delay = 135, -- Minimum time (in ms) between saves
		})
	end,
}
