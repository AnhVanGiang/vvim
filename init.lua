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
set_colorscheme("ofirkai") -- Set Monokai Pro as the default
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

		if success then
			local state = nt_manager.get_state("filesystem") -- Get the filesystem state
			local node = state and state.tree:get_node() or nil
			file_path = node and node.path or ""
		end

		if file_path == "" then
			-- Fallback: Use the current buffer's file path
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

		-- Generate output file name
		local output_path = dir .. base_name .. ".parquet"

		-- Get the orient argument or use "index" as default
		local orient = opts.args or "index" -- Default to "index" if no argument is provided

		-- Run Python script for conversion
		local result = vim.fn.system({
			"python3",
			"-c",
			[[
        import pandas as pd
        import sys
        try:
            input_file = sys.argv[1]
            output_file = sys.argv[2]
            orient = sys.argv[3]
            df = pd.read_json(input_file, orient=orient)
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
		})

		-- Print result
		print(result)
	end,
	{ nargs = "?" } -- Allow an optional argument
)
