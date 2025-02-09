return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end, noremap = true, desc = "Smart Find Files" },
    -- { "<leader>,", function() Snacks.picker.buffers() end, noremap = true, desc = "Buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, noremap = true, desc = "Grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, noremap = true, desc = "Command History" },
    { "<leader>n", function() Snacks.picker.notifications() end, noremap = true, desc = "Notification History" },
    -- { "<leader>e", function() Snacks.explorer() end, noremap = true, desc = "File Explorer" },
    -- find
    { "<leader>fb", function() Snacks.picker.buffers() end, noremap = true, desc = "Buffers" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, noremap = true, desc = "Find Config File" },
    { "<leader>ff", function() Snacks.picker.files() end, noremap = true, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end, noremap = true, desc = "Find Git Files" },
    { "<leader>fp", function() Snacks.picker.projects() end, noremap = true, desc = "Projects" },
    { "<leader>fr", function() Snacks.picker.recent() end, noremap = true, desc = "Recent" },
    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, noremap = true, desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end, noremap = true, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, noremap = true, desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end, noremap = true, desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end, noremap = true, desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, noremap = true, desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, noremap = true, desc = "Git Log File" },
    -- Grep
    { "<leader>sb", function() Snacks.picker.lines() end, noremap = true, desc = "Buffer Lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, noremap = true, desc = "Grep Open Buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, noremap = true, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, noremap = true, desc = "Visual selection or word", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, noremap = true, desc = "Registers" },
    { '<leader>s/', function() Snacks.picker.search_history() end, noremap = true, desc = "Search History" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, noremap = true, desc = "Autocmds" },
    { "<leader>sb", function() Snacks.picker.lines() end, noremap = true, desc = "Buffer Lines" },
    { "<leader>sc", function() Snacks.picker.command_history() end, noremap = true, desc = "Command History" },
    { "<leader>sC", function() Snacks.picker.commands() end, noremap = true, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, noremap = true, desc = "Diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, noremap = true, desc = "Buffer Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, noremap = true, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, noremap = true, desc = "Highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, noremap = true, desc = "Icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, noremap = true, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, noremap = true, desc = "Keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, noremap = true, desc = "Location List" },
    { "<leader>sm", function() Snacks.picker.marks() end, noremap = true, desc = "Marks" },
    { "<leader>sM", function() Snacks.picker.man() end, noremap = true, desc = "Man Pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end, noremap = true, desc = "Search for Plugin Spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, noremap = true, desc = "Quickfix List" },
    { "<leader>sR", function() Snacks.picker.resume() end, noremap = true, desc = "Resume" },
    { "<leader>su", function() Snacks.picker.undo() end, noremap = true, desc = "Undo History" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, noremap = true, desc = "Colorschemes" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, noremap = true, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, noremap = true, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, noremap = true, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, noremap = true, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, noremap = true, desc = "Goto T[y]pe Definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, noremap = true, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, noremap = true, desc = "LSP Workspace Symbols" },
    -- Other
    { "<leader>z",  function() Snacks.zen() end, noremap = true, desc = "Toggle Zen Mode" },
    { "<leader>Z",  function() Snacks.zen.zoom() end, noremap = true, desc = "Toggle Zoom" },
    { "<leader>.",  function() Snacks.scratch() end, noremap = true, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, noremap = true, desc = "Select Scratch Buffer" },
    { "<leader>n",  function() Snacks.notifier.show_history() end, noremap = true, desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end, noremap = true, desc = "Delete Buffer" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, noremap = true, desc = "Rename File" },
    { "<leader>gB", function() Snacks.gitbrowse() end, noremap = true, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>gg", function() Snacks.lazygit() end, noremap = true, desc = "Lazygit" },
    { "<leader>un", function() Snacks.notifier.hide() end, noremap = true, desc = "Dismiss All Notifications" },
    { "<c-/>",      function() Snacks.terminal() end, noremap = true, desc = "Toggle Terminal" },
    { "<c-_>",      function() Snacks.terminal() end, noremap = true, desc = "which_key_ignore" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, noremap = true, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, noremap = true, desc = "Prev Reference", mode = { "n", "t" } },
    {
      "<leader>N",
      noremap = true,
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
