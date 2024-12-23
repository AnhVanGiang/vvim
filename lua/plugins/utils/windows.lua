return {
  "anuvyklack/windows.nvim",
  dependencies = {
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim"
  },
  config = function()
    -- Set vim options for the plugin
    vim.o.winwidth = 10
    vim.o.winminwidth = 10
    vim.o.equalalways = false

    -- Call the setup function for the plugin
    require("windows").setup()
  end
}
