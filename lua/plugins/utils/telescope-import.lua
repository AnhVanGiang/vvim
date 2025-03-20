return {
  'piersolenski/telescope-import.nvim',
  enabled = false,
  dependencies = 'nvim-telescope/telescope.nvim',
  config = function()
    require("telescope").load_extension("import")
  end
}
