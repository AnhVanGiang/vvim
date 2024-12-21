return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  enabled = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {
      view = {
        mappings = {
          list = {
            { key = "h", action = "parent_node" }, -- Move to parent directory
            { key = "l", action = "edit" },        -- Open node
          },
        },
      },
    }
  end,
}
