return {
  "nvim-telescope/telescope-frecency.nvim",
  -- install the latest stable version
  version = "*",
  enabled = false,
  config = function()
    require("telescope").load_extension "frecency"
  end,
}
