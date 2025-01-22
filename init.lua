-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Nvim's core settings without plugins
-- ────────────────────────────────────────────────────────────────────────────────────────────────
require("core")

-- Overwrite some custom paths if needed (already defined in lua/core/settings.lua)
-- vim.g.python3_host_prog = ""
-- vim.opt.spellfile = ""

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Setup plugins with the package-manager lazy.nvim
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Bootstrap lazy.nvim on 1st install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local plugins_cfg_dir = "plugins"
vim.o.scroll = 8
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
	install = {
		colorscheme = { "monokai-pro", "catppuccin-macchiato", "habamax" },
	},
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
set_colorscheme("catppuccin-macchiato")
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

vim.api.nvim_create_user_command(
	"ConvertIpynbToPy",
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
			"jupyter",
			"nbconvert",
			"--to",
			"script",
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
-- function OpenFloatingTerminal()
--   local buf = vim.api.nvim_create_buf(false, true) -- Create a new empty buffer
--   local opts = {
--     relative = "editor",
--     width = math.floor(vim.o.columns * 0.8), -- 80% of the editor width
--     height = math.floor(vim.o.lines * 0.8),  -- 80% of the editor height
--     row = math.floor(vim.o.lines * 0.1),     -- Centered vertically
--     col = math.floor(vim.o.columns * 0.1),  -- Centered horizontally
--     style = "minimal",
--     border = "rounded", -- Optional: rounded border
--   }
--
--   -- Open the terminal in the floating window
--   local win = vim.api.nvim_open_win(buf, true, opts)
--   vim.fn.termopen(vim.o.shell) -- Open a terminal in the buffer
--   vim.cmd("startinsert") -- Start in insert mode
--   return win
-- end

-- vim.keymap.set("n", "<leader>ft", ":lua OpenFloatingTerminal()<CR>", { noremap = true, silent = true, desc="Open floating terminal" })
-- -- movement
-- vim.keymap.set({ 'n', 'v' }, '<C-k>', '<cmd>Treewalker Up<cr>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<C-j>', '<cmd>Treewalker Down<cr>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<C-l>', '<cmd>Treewalker Right<cr>', { silent = true })
-- vim.keymap.set({ 'n', 'v' }, '<C-h>', '<cmd>Treewalker Left<cr>', { silent = true })
--
-- -- swapping
-- vim.keymap.set('n', '<C-S-j>', '<cmd>Treewalker SwapDown<cr>', { silent = true })
-- vim.keymap.set('n', '<C-S-k>', '<cmd>Treewalker SwapUp<cr>', { silent = true })
-- vim.keymap.set('n', '<C-S-l>', '<cmd>Treewalker SwapRight<CR>', { silent = true })
-- vim.keymap.set('n', '<C-S-h>', '<cmd>Treewalker SwapLeft<CR>', { silent = true })
--
-- vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true, desc = "Open a new tab" })
-- vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true, desc = "Close the current tab" })
-- vim.keymap.set('n', '<leader>ts', ':tab split<CR>', { noremap = true, silent = true, desc = "Split tab" })
-- -- vim.api.nvim_set_keymap('n', '<leader>tp', ':tabprevious<CR>', { noremap = true, silent = true, desc = "Go to the previous tab" })
-- -- vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnext<CR>', { noremap = true, silent = true, desc = "Go to the next tab" })
-- local function add_cell_marker()
--   local line = vim.api.nvim_get_current_line() -- Get the current line
--   if line == "" then
--     -- If the line is empty, set it to "# %%"
--     vim.api.nvim_set_current_line("# %%")
--   else
--     -- Otherwise, append a new line below with "# %%"
--     local row, _ = unpack(vim.api.nvim_win_get_cursor(0)) -- Get the current row number
--     vim.api.nvim_buf_set_lines(0, row, row, false, { "# %%" })
--   end
-- end
--
-- -- Map to <leader>c using vim.keymap.set
-- vim.keymap.set("n", "<space>ac", add_cell_marker, {noremap = true, desc = "Add # %% to the current or new line" })
