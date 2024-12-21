return {
  "Pocco81/auto-save.nvim",
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
      trigger_events = {"InsertLeave", "TextChanged"}, -- Auto-save on these events
      condition = function(buf)
        -- Only save if the buffer is not read-only and is a normal file
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {"gitcommit", "markdown"}) then
          return true
        end
        return false
      end,
      write_all_buffers = false, -- Save only the current buffer
      debounce_delay = 135, -- Minimum time (in ms) between saves
    })
  end,
}
