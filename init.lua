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

vim.keymap.set(
	"n",
	"<leader>rt",
	toggle_boolean,
	{ noremap = true, silent = true, desc = "Change boolean" }
)
