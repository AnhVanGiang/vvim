return {
  {
    "tpope/vim-dadbod",
    enabled = true,
    dependencies = {
      "kristijanhusak/vim-dadbod-ui",         -- Optional: UI for vim-dadbod
      "kristijanhusak/vim-dadbod-completion" -- Optional: Completion for vim-dadbod
    },
    cmd = {
      "DB",    -- For executing SQL queries
      "DBUI",  -- Opens the database UI
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer"
    },
    config = function()
      -- Optional: Set up any configuration here if needed
      vim.g.db_ui_save_location = "~/.config/nvim/db_ui" -- Change the location of saved DBUI sessions
    end
  }
}
