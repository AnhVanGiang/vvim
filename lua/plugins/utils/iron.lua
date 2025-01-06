return {
    "Vigemus/iron.nvim",
    config = function()
        local iron = require("iron.core")
        local view = require("iron.view")

        iron.setup {
            config = {
                -- Whether a repl should be discarded or not
                scratch_repl = true,
                -- Your repl definitions come here
                repl_definition = {
                    sh = {
                        -- Can be a table or a function that
                        -- returns a table (see below)
                        command = { "zsh" }
                    },
                    python = {
                        command = { "ipython", "--no-autoindent" },
                        format = require("iron.fts.common").bracketed_paste_python
                    }
                },
                -- How the repl window will be displayed
                -- See below for more information
                -- repl_open_cmd = require("iron.view").bottom(40),
                -- Using the new view functions instead of the above line:
                -- You can choose any of the examples below, uncomment only the one you want

                -- Example 1: Vertical split, 80 columns wide
                -- repl_open_cmd = "vertical botright 80 split",
                repl_open_cmd = view.split.vertical.botright(80),

                -- Example 2: Vertical split, 61.9% of the window width
                -- repl_open_cmd = view.split.vertical.botright(0.61903398875),

                -- Example 3: Horizontal split, 40% of the window height
                -- repl_open_cmd = view.split("40%"),

                -- Example 4: Top-left split with dynamic height based on a condition
                -- repl_open_cmd = view.split.topleft(function()
                --   if some_check then
                --     return vim.o.lines * 0.4
                --   end
                --   return 20
                -- end),

                -- Example 5: Split with custom window options (e.g., disabling fixwidth/fixheight)
                -- repl_open_cmd = view.split("40%", {
                --   winfixwidth = false,
                --   winfixheight = false,
                --   -- any window-local configuration can be used here
                --   number = true
                -- }),
            },
            -- Iron doesn't set keymaps by default anymore.
            -- You can set them here or manually add keymaps to the functions in iron.core
            keymaps = {
                send_motion = "<space>sc",
                visual_send = "<space>sc",
                send_file = "<space>sf",
                send_line = "<space>sl",
                send_paragraph = "<space>sp",
                send_until_cursor = "<space>su",
                send_mark = "<space>sm",
                mark_motion = "<space>mc",
                mark_visual = "<space>mc",
                remove_mark = "<space>md",
                cr = "<space>s<cr>",
                interrupt = "<space>s<space>",
                exit = "<space>sq",
                -- clear = "<space>scl",
            },
            -- If the highlight is on, you can change how it looks
            -- For the available options, check nvim_set_hl
            highlight = {
                italic = true
            },
            ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        }

        -- iron also has a list of commands, see :h iron-commands for all available commands
        vim.keymap.set("n", "<space>rs", "<cmd>IronReplHere<cr>")
        vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
        vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
        vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
        vim.keymap.set("n", "<space>ra", "<cmd>IronAttach<cr>")
        vim.keymap.set("n", "<space>sw", function()
            require("iron.core").send(nil, { "whos" })
        end, { desc = "Send 'whos' to REPL" })

        vim.keymap.set("n", "<space>scl", function()
            require("iron.core").send(nil, { "clear" })
        end, { desc = "Send 'clear' to REPL" })
    end
}
