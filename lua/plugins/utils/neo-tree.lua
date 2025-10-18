-- File explorer
return {
	-- Neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		-- branch = "v3.x",
		event = "VeryLazy",
		enabled = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{ "<leader>e", "<CMD>Neotree toggle<CR>", desc = "Neotree: Toggle file tree" },
			{ "<leader>E", "<CMD>Neotree reveal<CR>", desc = "Neotree: Open tree at the current file" },
		},
		config = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
			require("neo-tree").setup({
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				source_selector = {
					winbar = true,
					statusline = true,
				},
				filesystem = {
					group_empty_dirs = true, -- when true, empty folders will be grouped together
					-- auto_preview = true
				},
				window = {
					mappings = {
						-- ["s"] = function()
						-- 	-- Call Leap's forward jump function
      --                       require("flash").jump()
						-- end,
						-- ["S"] = function()
						-- 	-- Call Leap's backward jump function
						-- 	require("leap").leap({ backward = true, target_windows = { vim.fn.win_getid() } })
						-- end, -- ["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
						["<CR>"] = "focus_preview",
						["<C-u>"] = { "scroll_preview", config = { direction = 10 } },
						["<C-d>"] = { "scroll_preview", config = { direction = -10 } },
						["zz"] = function()
							vim.cmd("normal! zz")
						end,
						-- Open with system defaults
						-- ["O"] = {
						-- 	command = function(state)
						-- 		local node = state.tree:get_node()
						-- 		local filepath = node.path
						-- 		---@diagnostic disable-next-line: undefined-field
						-- 		local ostype = vim.uv.os_uname().sysname
						-- 		local command
						--
						-- 		if ostype == "Windows_NT" then
						-- 			command = "start " .. filepath
						-- 		elseif ostype == "Darwin" then
						-- 			command = "open " .. filepath
						-- 		else
						-- 			command = "xdg-open " .. filepath
						-- 		end
						-- 		os.execute(command)
						-- 	end,
						-- 	desc = "open_with_system_defaults",
						-- },
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
							if not node then
								vim.notify("No node selected!", vim.log.levels.ERROR)
								return
							end

							local filepath = node:get_id()
							local filename = node.name
							local modify = vim.fn.fnamemodify

							local results = {
								filepath,
								modify(filepath, ":."), -- Path relative to CWD
								modify(filepath, ":~"), -- Path relative to HOME
								filename,
								modify(filename, ":r"), -- Filename without extension
								modify(filename, ":e"), -- Extension of the filename
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

							if i > 0 and i <= #results then
								local result = results[i]
								if not result then
									vim.notify("Invalid choice: " .. i, vim.log.levels.ERROR)
									return
								end
								-- Copy to system clipboard
								vim.fn.setreg("+", result)
								vim.notify("Copied to system clipboard: " .. result)
							else
								vim.notify("No valid choice made.", vim.log.levels.WARN)
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
