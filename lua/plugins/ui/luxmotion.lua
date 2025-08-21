return {
  "LuxVim/nvim-luxmotion",
  enabled = false,
  config = function()
    require("luxmotion").setup({
      cursor = {
        duration = 250,
        easing = "ease-out",
        enabled = true,
      },
      scroll = {
        duration = 400,
        easing = "ease-out",
        enabled = true,
      },
      performance = { enabled = true },
      keymaps = {
        cursor = true,
        scroll = false,
      },
    })
  end,
}
