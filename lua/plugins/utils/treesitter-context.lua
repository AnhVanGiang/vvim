return {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = false,
  dependencies = {"nvim-treesitter/nvim-treesitter"},
  config = function()
    require("treesitter-context").setup()
  end
}
