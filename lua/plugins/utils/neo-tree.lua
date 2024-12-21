-- File explorer
return {
    -- Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>t", "<CMD>Neotree toggle<CR>", desc = "Neotree: Toggle file tree" },
            { "<leader>T", "<CMD>Neotree reveal<CR>", desc = "Neotree: Open tree at the current file" },
        },
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
            require("neo-tree").setup({
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                source_selector = {
                    winbar = true,
                    statusline = false,
                },
                filesystem = {
                    group_empty_dirs = true, -- when true, empty folders will be grouped together
                },
                window = {
                    mappings = {
                        -- Open with system defaults
                        ["O"] = {
                            command = function(state)
                                local node = state.tree:get_node()
                                local filepath = node.path
                                ---@diagnostic disable-next-line: undefined-field
                                local ostype = vim.uv.os_uname().sysname
                                local command

                                if ostype == "Windows_NT" then
                                    command = "start " .. filepath
                                elseif ostype == "Darwin" then
                                    command = "open " .. filepath
                                else
                                    command = "xdg-open " .. filepath
                                end
                                os.execute(command)
                            end,
                            desc = "open_with_system_defaults",
                        },
                        -- Custom mappings
                        -- "h" moves to the parent directory and collapses the node
["h"] = function(state)
  local node = state.tree:get_node()
  if not node then
    return -- If no node is selected, do nothing
  end

  if node.type ~= "directory" or not node:is_expanded() then
    -- If not a directory or not expanded, move to the parent
    local parent_id = node:get_parent_id()
    if not parent_id then
      return -- If no parent exists, do nothing
    end
    node = state.tree:get_node(parent_id)
  end

  if node and node.type == "directory" then
    -- Collapse the directory
    node:collapse()
    state.tree:render()
    -- Focus on the collapsed node
    require("neo-tree.ui.renderer").focus_node(state, node:get_id())
  end
end,
                        -- "l" opens the node (edit action)
                        ["l"] = "open",
                        -- "Y" copies various file paths or filename components to the clipboard
                        ["Y"] = function(state)
                            -- NeoTree is based on NuiTree
                            local node = state.tree:get_node()
                            local filepath = node:get_id()
                            local filename = node.name
                            local modify = vim.fn.fnamemodify

                            local results = {
                                filepath,
                                modify(filepath, ":."),
                                modify(filepath, ":~"),
                                filename,
                                modify(filename, ":r"),
                                modify(filename, ":e"),
                            }

                            -- Prompt the user to choose a copy option
                            local i = vim.fn.inputlist({
                                "Choose to copy to clipboard:",
                                "1. Absolute path: " .. results[1],
                                "2. Path relative to CWD: " .. results[2],
                                "3. Path relative to HOME: " .. results[3],
                                "4. Filename: " .. results[4],
                                "5. Filename without extension: " .. results[5],
                                "6. Extension of the filename: " .. results[6],
                            })

                            if i > 0 then
                                local result = results[i]
                                if not result then return print("Invalid choice: " .. i) end
                                vim.fn.setreg('"', result)
                                vim.notify("Copied: " .. result)
                            end
                        end,
                    },
                },
                default_component_configs = {
                    diagnostics = {
                        symbols = {
                            hint = "󰌶",
                            info = "󰋽",
                            warn = "󰀪",
                            error = "󰅚",
                        },
                    },
                },
            })
        end,
    },
    -- Window picker
    -- only needed if you want to use the commands with '_with_window_picker' suffix
    {
        "s1n7ax/nvim-window-picker",
        version = "v2.*",
        event = "VeryLazy",
        opts = {
            hint = "floating-big-letter",
            selection_chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ",
            filter_rules = {
                -- filter using buffer options
                bo = {
                    -- if the file type is one of following, the window will be ignored
                    filetype = { "neo-tree", "neo-tree-popup", "notify" },
                    -- if the buffer type is one of following, the window will be ignored
                    buftype = { "terminal", "quickfix" },
                },
            },
        },
    },
}
