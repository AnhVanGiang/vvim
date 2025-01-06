return {
  "dccsillag/magma-nvim",
  enabled=false,
  build = ":UpdateRemotePlugins", -- Makes sure remote plugins are updated
  config = function()
    -- Magma global settings
    vim.g.magma_automatically_open_output = false -- Do not automatically open output
    -- vim.g.magma_image_provider = "ueberzug" -- Use 'ueberzug' for image rendering

    -- Key mappings for Magma (using <Space> as leader and 'm' for Magma commands)
    vim.api.nvim_set_keymap("n", "<Space>mr", ":MagmaEvaluateOperator<CR>", { noremap = true, silent = true, expr = false })
    vim.api.nvim_set_keymap("n", "<Space>mrr", ":MagmaEvaluateLine<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("x", "<Space>mr", ":<C-u>MagmaEvaluateVisual<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Space>mrc", ":MagmaReevaluateCell<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Space>mrd", ":MagmaDelete<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Space>ma", ":MagmaShowOutput<CR>", { noremap = true, silent = true })
  end,
}
