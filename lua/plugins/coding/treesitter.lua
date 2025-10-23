return {
  -- Code parser generator for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Automatically run `:TSUpdate` after installation
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Add parsers you want to ensure are installed
          "bibtex", "cmake", "cpp", "css", "dockerfile", "git_config", "html",
          "javascript", "json", "latex", "regex", "scala", "sql", "toml", "typescript", "yaml",
          "python", "lua", "vim", -- Additional parsers
        },
        highlight = {
          enable = true, -- Enable syntax highlighting
          -- Disable vim regex highlighting when TreeSitter is available
          additional_vim_regex_highlighting = false,
          disable = function(_, buf) -- Function to disable for large files
            -- Disable in large number of lines
            local max_n_lines = 50000
            if vim.api.nvim_buf_line_count(buf) > max_n_lines then
              return true
            end

            -- Disable in large buffer size
            local max_filesize = 100 * 1024 -- 100 KB
            ---@diagnostic disable-next-line: undefined-field
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = {
          enable = false, -- Disabled because Treesitter's indent is buggy
          disable = {},
        },
      })

      -- Explicitly disable traditional syntax highlighting for TreeSitter-supported files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python", "lua", "javascript", "typescript" },
        callback = function()
          vim.cmd("syntax off") -- Disable traditional syntax
          -- TreeSitter will handle highlighting
        end,
      })
    end,
  },

  -- Treesitter textobjects plugin
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Ensure it loads after nvim-treesitter
    event = "BufReadPost", -- Lazy-load after reading a buffer
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to the text object
            -- keymaps = {
            --   ["af"] = "@function.outer", -- Select outer function block
            --   ["if"] = "@function.inner", -- Select inner function block
            --   ["ac"] = "@class.outer",   -- Select outer class block
            --   ["ic"] = "@class.inner",   -- Select inner class block
            -- },
          },
          move = {
            enable = true,
            set_jumps = true, -- Set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer", -- Go to the start of the next function
              ["]]"] = "@class.outer",    -- Go to the start of the next class
            },
            goto_next_end = {
              ["]M"] = "@function.outer", -- Go to the end of the next function
              ["]["] = "@class.outer",    -- Go to the end of the next class
            },
            goto_previous_start = {
              ["[m"] = "@function.outer", -- Go to the start of the previous function
              ["[["] = "@class.outer",    -- Go to the start of the previous class
            },
            goto_previous_end = {
              ["[M"] = "@function.outer", -- Go to the end of the previous function
              ["[]"] = "@class.outer",    -- Go to the end of the previous class
            },
          },
        },
      })
    end,
  },
}
