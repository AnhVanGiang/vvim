return {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = true,
  dependencies = {"nvim-treesitter/nvim-treesitter"},
  config = function()
    require("treesitter-context").setup()
  end
}
