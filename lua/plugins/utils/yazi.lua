-- ~/.config/nvim/lua/plugins/yazi.lua
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<space>yy",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
      noremap = true,
    },
    {
      "<space>yc",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
      noremap = true,
},
    {
      '<c-up>',
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
