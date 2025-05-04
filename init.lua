-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Nvim's core settings without plugins
-- ────────────────────────────────────────────────────────────────────────────────────────────────
require("core")
-- Set leader to \
vim.g.mapleader = "\\"
-- Overwrite some custom paths if needed (already defined in lua/core/settings.lua)
-- vim.g.python3_host_prog = ""
-- vim.opt.spellfile = ""

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Setup plugins with the package-manager lazy.nvim
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Normal mode mappings
-- vim.api.nvim_set_keymap('n', 'K', ':m .-2<CR>==', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'J', ':m .+1<CR>==', { noremap = true, silent = true })
--
-- -- Visual mode mappings
-- vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local plugins_cfg_dir = "plugins"
-- Window resizing with Ctrl+arrows
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { silent = true })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { silent = true })
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Lazy.nvim Configuration
-- ────────────────────────────────────────────────────────────────────────────────────────────────
require("lazy").setup({
	spec = {
		-- Import your plugin configurations from the plugins directory
		{ import = plugins_cfg_dir },
	},
	-- Automatically install plugins and set default colorscheme
	-- install = {
	-- 	colorscheme = { "monokai-pro", "catppuccin-macchiato", "habamax" },
	-- },
	-- Automatically check for updates
	checker = { enabled = true },

	-- Custom UI settings
	ui = {
		border = "rounded",
	},
})

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Set the default colorscheme
-- ────────────────────────────────────────────────────────────────────────────────────────────────
local function set_colorscheme(scheme)
	local ok, _ = pcall(vim.cmd.colorscheme, scheme)
	if not ok then
		vim.notify("Colorscheme '" .. scheme .. "' not found! Falling back to default.", vim.log.levels.WARN)
	end
end

-- Set your preferred colorscheme here
set_colorscheme("tokyonight-moon")
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.py",
	command = "set filetype=python",
})
-- vim.o.shell = '/opt/homebrew/bin/fish'
vim.api.nvim_create_user_command(
	"ConvertToParquet",
	function(opts)
		-- Attempt to get the selected file in NeoTree
		local file_path = ""
		local success, nt_manager = pcall(require, "neo-tree.sources.manager")

		-- Get the file path from NeoTree if available
		if success then
			local state = nt_manager.get_state("filesystem") -- Get the filesystem state
			local node = state and state.tree:get_node() or nil
			file_path = node and node.path or ""
		end

		-- Fallback: Use the current buffer's file path
		if file_path == "" then
			file_path = vim.fn.expand("%:p")
		end

		-- Debugging: Print the selected file path
		print(string.format("Selected file name is %s", file_path))

		-- Check if the file is a .json file
		if not file_path:match("%.json$") then
			print("Error: Selected file is not a .json file")
			return
		end

		-- Extract directory and base name
		local dir = file_path:match("(.*/)")
		local base_name = file_path:match("([^/]+)%.json$")
		local output_path = dir .. base_name .. ".parquet"

		-- Get the orient argument or use "index" as default
		local orient = opts.args or "index"

		-- Run the Python script asynchronously
		vim.fn.jobstart({
			"python3",
			"-c",
			[[
import pandas as pd
import sys
try:
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    orient = sys.argv[3]
    df = pd.read_json(input_file, orient='index')
    df.to_parquet(output_file)
    print(f"Converted {input_file} to {output_file} with orient='{orient}'")
except ValueError as e:
    print(f"Error: Invalid orient '{orient}' - {e}")
except Exception as e:
    print(f"Error: {e}")
      ]],
			file_path,
			output_path,
			orient,
		}, {
			stdout_buffered = true,
			stderr_buffered = true,
			on_stdout = function(_, data, _)
				if data then
					print(table.concat(data, "\n"))
				end
			end,
			on_stderr = function(_, data, _)
				if data then
					print(table.concat(data, "\n"))
				end
			end,
			on_exit = function(_, exit_code, _)
				if exit_code == 0 then
					print("Conversion completed successfully.")
				else
					print("Conversion failed. Check the error messages.")
				end
			end,
		})
	end,
	{ nargs = "?" } -- Allow an optional argument
)

vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>', { silent = true })

-- swapping
vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<CR>', { silent = true })
vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<CR>', { silent = true })

-- Create a command that opens a terminal in a vertical split
vim.api.nvim_create_user_command('VSTerminal', function()
  -- Create a vertical split
  vim.cmd('vsplit')
  -- Open terminal in the new split
  vim.cmd('terminal')
end, {})

vim.api.nvim_create_user_command(
	"ConvertIpynbToPy",
	function()
		-- Attempt to get the selected file from Yazi
		local file_path = ""
		local success, nt_manager = pcall(require, "neo-tree.sources.manager")

		-- Get the file path from NeoTree if available
		if success then
			local state = nt_manager.get_state("filesystem") -- Get the filesystem state
			local node = state and state.tree:get_node() or nil
			file_path = node and node.path or ""
		end

		-- Fallback: Use the current buffer's file path
		if file_path == "" then
			file_path = vim.fn.expand("%:p")
		end

		-- Debugging: Print the selected file path
		print(string.format("Selected file name is %s", file_path))

		-- Check if the file is a .ipynb file
		if not file_path:match("%.ipynb$") then
			print("Error: Selected file is not a .ipynb file")
			return
		end

		-- Extract directory and base name
		local dir = file_path:match("(.*/)")
		local base_name = file_path:match("([^/]+)%.ipynb$")
		local output_path = dir .. base_name .. ".py"

		-- Run the nbconvert command asynchronously
		vim.fn.jobstart({
			"jupytext",
			"--to",
			"py",
			file_path,
		}, {
			stdout_buffered = true,
			stderr_buffered = true,
			on_stdout = function(_, data, _)
				if data then
					print(table.concat(data, "\n"))
				end
			end,
			on_stderr = function(_, data, _)
				if data then
					print(table.concat(data, "\n"))
				end
			end,
			on_exit = function(_, exit_code, _)
				if exit_code == 0 then
					print(string.format("Conversion completed successfully: %s", output_path))
				else
					print("Conversion failed. Check the error messages.")
				end
			end,
		})
	end,
	{ nargs = "?" } -- Allow an optional argument
)

vim.api.nvim_create_user_command(
	"ConvertPyToIpynb",
	function()
		-- Attempt to get the selected file in NeoTree
		local file_path = ""
		local success, nt_manager = pcall(require, "neo-tree.sources.manager")

		-- Get the file path from NeoTree if available
		if success then
			local state = nt_manager.get_state("filesystem") -- Get the filesystem state
			local node = state and state.tree:get_node() or nil
			file_path = node and node.path or ""
		end

		-- Fallback: Use the current buffer's file path
		if file_path == "" then
			file_path = vim.fn.expand("%:p")
		end

		-- Debugging: Print the selected file path
		print(string.format("Selected file name is %s", file_path))

		-- Check if the file is a .ipynb file
		if not file_path:match("%.py$") then
			print("Error: Selected file is not a .py file")
			return
		end

		-- Extract directory and base name
		local dir = file_path:match("(.*/)")
		local base_name = file_path:match("([^/]+)%.py$")
		local output_path = dir .. base_name .. ".py"

		-- Run the nbconvert command asynchronously
		vim.fn.jobstart({
			"jupytext",
			"--to",
			"notebook",
			file_path,
		}, {
			stdout_buffered = true,
			stderr_buffered = true,
			on_stdout = function(_, data, _)
				if data then
					print(table.concat(data, "\n"))
				end
			end,
			on_stderr = function(_, data, _)
				if data then
					print(table.concat(data, "\n"))
				end
			end,
			on_exit = function(_, exit_code, _)
				if exit_code == 0 then
					print(string.format("Conversion completed successfully: %s", output_path))
				else
					print("Conversion failed. Check the error messages.")
				end
			end,
		})
	end,
	{ nargs = "?" } -- Allow an optional argument
)
local function toggle_boolean()
	-- Get the word under the cursor
	local word = vim.fn.expand("<cword>")

	-- Define the toggle logic
	if word == "True" then
		vim.cmd("normal! ciwFalse")
	elseif word == "False" then
		vim.cmd("normal! ciwTrue")
	elseif word == "true" then
		vim.cmd("normal! ciwfalse")
	elseif word == "false" then
		vim.cmd("normal! ciwtrue")
	else
		print("Not a Boolean value")
	end
end

vim.keymap.set("n", "<leader>rt", toggle_boolean, { noremap = true, silent = true, desc = "Change boolean" })

-- Auto select virtualenv Nvim open
vim.api.nvim_create_user_command('SelectPoetryVenv', function()
  -- Check for `pyproject.toml` in the current directory or parent directories
  local pyproject_file = vim.fn.findfile('pyproject.toml', vim.fn.getcwd() .. ';')
  if pyproject_file ~= '' then
    -- Use venv-selector's retrieve_from_cache or open a selector UI
    local venv_selector = require('venv-selector')
    local venv = venv_selector.retrieve_from_cache() -- Try to get the cached venv

    if venv ~= nil and venv ~= '' then
      print('Using cached venv: ' .. venv)
    else
      -- Open the selector UI if no cached venv is found
      print('No cached venv found')
      -- venv_selector.select_venv()
    end
  else
    print('No `pyproject.toml` found in the current project.')
  end
end, {
  desc = 'Use venv-selector to activate Poetry virtualenv for the current project',
})

vim.keymap.set("i", "<C-e>", function()
  -- Debug: Notify that the function was triggered
  print("Function triggered!")

  -- Define matching pairs
  local pair_chars = { ["("] = ")", ["["] = "]", ["{"] = "}", ['"'] = '"', ["'"] = "'" }
  local col = vim.fn.col('.')  -- Current cursor column
  local line = vim.fn.getline('.') -- Current line

  -- Debug: Print current column and line
  print("Current column:", col)
  print("Current line:", line)

  -- If we're at the end of the line, do nothing
  if col > #line then
    print("At the end of the line, no action taken.")
    return
  end

  local char_at_cursor = line:sub(col, col) -- Character under the cursor
  local char_after_cursor = line:sub(col + 1, col + 1) -- Character after the cursor

  -- Debug: Print characters at and after the cursor
  print("Char at cursor:", char_at_cursor)
  print("Char after cursor:", char_after_cursor)

  -- If the character after the cursor matches a closing pair, move the cursor forward
  if pair_chars[char_at_cursor] == char_after_cursor then
    print("Match found! Moving cursor forward.")
    vim.cmd("normal! l")
  else
    print("No match found.")
  end
end, { noremap = true, silent = true })

vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })
vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })
vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })

-- Define a namespace for duplicate highlights
local ns_id = vim.api.nvim_create_namespace("duplicate_highlight")

local function highlight_duplicates()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local occurrences = {}

  -- Build a table of line text to its line numbers (0-indexed)
  for i, line in ipairs(lines) do
    if line ~= "" then  -- skip empty lines if desired
      occurrences[line] = occurrences[line] or {}
      table.insert(occurrences[line], i - 1)
    end
  end

  -- Clear previous highlights in our namespace
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  -- Highlight lines that appear more than once
  for _, line_numbers in pairs(occurrences) do
    if #line_numbers > 1 then
      for _, line_num in ipairs(line_numbers) do
        vim.api.nvim_buf_add_highlight(bufnr, ns_id, "Search", line_num, 0, -1)
      end
    end
  end
end

-- Create a user command for convenience
vim.api.nvim_create_user_command("HighlightDuplicates", highlight_duplicates, {})

local function clear_duplicate_highlights()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
end

vim.api.nvim_create_user_command("ClearDuplicateHighlights", clear_duplicate_highlights, {})
-- Combination approach
vim.o.equalalways = false  -- Disable equal window sizing
vim.o.eadirection = "ver"  -- Only allow vertical adjustments
vim.opt.scroll = 30
vim.api.nvim_create_user_command('BufCloseType', function(opts)
  vim.cmd('bufdo if expand("%:e") == "' .. opts.args .. '" | bd | endif')
end, { nargs = 1 })

vim.api.nvim_create_user_command('TogglePrintComments', function()
  -- Get the visual selection
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  
  -- Get all lines in the selection
  local lines = vim.api.nvim_buf_get_lines(0, start_line-1, end_line, false)
  
  -- Determine if we should comment or uncomment
  local should_comment = false
  for _, line in ipairs(lines) do
    if line:match("^%s*print") and not line:match("^%s*#") then
      should_comment = true
      break
    end
  end
  
  -- Process each line
  for i, line in ipairs(lines) do
    if line:match("^%s*print") or line:match("^%s*#%s*print") then
      if should_comment then
        -- Comment the line if it's not already commented
        if not line:match("^%s*#") then
          lines[i] = line:gsub("^(%s*)(print)", "%1# %2")
        end
      else
        -- Uncomment the line
        lines[i] = line:gsub("^(%s*)#%s*", "%1")
      end
    end
  end
  
  -- Replace the lines in the buffer
  vim.api.nvim_buf_set_lines(0, start_line-1, end_line, false, lines)
end, {range = true})

vim.api.nvim_create_user_command('OpenInCursor', function()
  local project_dir = vim.fn.getcwd()
  vim.fn.system('open -a Cursor "' .. project_dir .. '"')
end, {})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({higroup="IncSearch", timeout=150})
  end,
  group = vim.api.nvim_create_augroup('highlight_yank', {clear = true}),
  pattern = '*',
})

vim.keymap.set(
  "n",
  "<leader>k",
  '<cmd>lua require("kubectl").toggle({ tab = true })<cr>',
  { noremap = true, silent = true }
)

vim.api.nvim_create_user_command('ConvertPyCells', function()
    vim.cmd([[%s/^# [+-]$/# %%/g]])
end, {})

vim.o.shell = '/opt/homebrew/bin/fish'

vim.keymap.set('n', '<leader>ds', '<Cmd>split<CR><Cmd>lua vim.lsp.buf.definition()<CR>', {
  noremap = true,
  silent = true,
  desc = "LSP Definition Horizontal Split"
})

-- Go to definition in a new vertical split
vim.keymap.set('n', '<leader>dv', '<Cmd>vsplit<CR><Cmd>lua vim.lsp.buf.definition()<CR>', {
  noremap = true,
  silent = true,
  desc = "LSP Definition Vertical Split"
})

vim.keymap.set("n", "ycc", "yygccp", { remap = true })
vim.keymap.set("n", "<leader>ca", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })


