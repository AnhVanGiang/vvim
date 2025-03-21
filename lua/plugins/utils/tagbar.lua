return {
  {
    "preservim/tagbar",
    enabled = false,
    cmd = { "TagbarOpen", "TagbarToggle" },
    keys = { { "<leader>tt", ":TagbarToggle<CR>", desc = "Toggle Tagbar" } },
    config = function()
      vim.g.tagbar_autofocus = 1
      vim.g.tagbar_width = 30
      vim.g.tagbar_autoclose = 1
      vim.g.tagbar_position = 'rightbelow vertical'
    end,
  },
}
