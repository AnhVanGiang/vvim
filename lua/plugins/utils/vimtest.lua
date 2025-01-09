return {
  {
    "vim-test/vim-test",
    enabled=false,
    config = function()
      -- Optional: Configure vim-test settings
      vim.g["test#strategy"] = "neovim" -- Use Neovim terminal for running tests
    end,
    keys = {
      -- Key mappings for vim-test
      { "<leader>tn", ":TestNearest<CR>", desc = "Run nearest test" },
      { "<leader>tf", ":TestFile<CR>", desc = "Run all tests in file" },
      { "<leader>ts", ":TestSuite<CR>", desc = "Run the entire test suite" },
      { "<leader>tl", ":TestLast<CR>", desc = "Run the last test" },
      { "<leader>gt", ":TestVisit<CR>", desc = "Visit the last test file" },
    },
  },
}
