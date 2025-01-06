return {
  {
    "ellisonleao/dotenv.nvim", -- The plugin name
    config = function()
      require("dotenv").setup({
        enable_on_load = true, -- Automatically load .env files when buffers are loaded
        verbose = false, -- Disable notifications for missing .env files
      })
    end,
  },
}
