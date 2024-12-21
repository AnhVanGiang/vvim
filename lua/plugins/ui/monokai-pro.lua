return {
  -- Add the Monokai Pro theme plugin
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false, -- Load immediately
    priority = 1000, -- Ensure it loads first
    config = function()
      require("monokai-pro").setup({
        filter = "pro", -- Available filters: classic, octagon, pro, machine, ristretto, spectrum
      })
      vim.cmd.colorscheme("monokai-pro")
    end,
  },
}
