return {
  'oribarilan/lensline.nvim',
  enabled = false,
  branch = 'release/1.x', -- or: tag = '1.0.0' for latest non-breaking updates
  event = 'LspAttach',
  config = function()
    require("lensline").setup({
    })
  end,
}
