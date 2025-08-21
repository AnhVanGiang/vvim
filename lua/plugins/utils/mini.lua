return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    keys = {
      { "<space>mf", function() require("mini.files").open(vim.api.nvim_buf_get_name(0)) end, desc = "Mini Files: Open" },
    },
    config = function()
      require('mini.files').setup()
      -- You can configure other mini modules here
      -- For example:
      -- require('mini.statusline').setup()
      -- require('mini.tabline').setup()
      -- require('mini.starter').setup()
    end,
  },
}