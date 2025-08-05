return {
	"rgroli/other.nvim",
	event = "VeryLazy",
	config = function()
		require("other-nvim").setup({
			mappings = {
				-- Builtin mappings for common project structures
				"livewire",
				"angular",
				"laravel",
				"rails",
				"golang",
				"python",
				"react",
				"rust",
				"elixir",
				"clojure",
				-- React/TypeScript patterns
				{
					pattern = "/src/components/(.*)/(.*)%.tsx$",
					target = "/src/components/%1/%2.test.tsx",
					transformer = "lowercase"
				},
				{
					pattern = "/src/components/(.*)/(.*)%.test%.tsx$",
					target = "/src/components/%1/%2.tsx",
					transformer = "lowercase"
				},
				{
					pattern = "/src/pages/(.*)/(.*)%.tsx$",
					target = "/src/pages/%1/%2.test.tsx",
					transformer = "lowercase"
				},
				
				-- Python patterns - Standard pytest structure
				{
					pattern = "/(.*)/(.*)%.py$",
					target = "/tests/%1/test_%2.py",
					context = "source_to_test"
				},
				{
					pattern = "/tests/(.*)/test_(.*)%.py$",
					target = "/%1/%2.py", 
					context = "test_to_source"
				},
				
				-- Python patterns - Django structure
				{
					pattern = "/(.*)/models%.py$",
					target = "/%1/tests/test_models.py"
				},
				{
					pattern = "/(.*)/views%.py$", 
					target = "/%1/tests/test_views.py"
				},
				{
					pattern = "/(.*)/serializers%.py$",
					target = "/%1/tests/test_serializers.py"
				},
				{
					pattern = "/(.*)/tests/test_(.*)%.py$",
					target = "/%1/%2.py"
				},
				
				-- Python patterns - Package structure (src layout)
				{
					pattern = "/src/(.*)/(.*)%.py$",
					target = "/tests/%1/test_%2.py"
				},
				{
					pattern = "/tests/(.*)/test_(.*)%.py$",
					target = "/src/%1/%2.py"
				},
				
				-- Python patterns - FastAPI structure  
				{
					pattern = "/app/api/v1/endpoints/(.*)%.py$",
					target = "/tests/api/v1/test_%1.py"
				},
				{
					pattern = "/app/core/(.*)%.py$",
					target = "/tests/core/test_%1.py"
				},
				{
					pattern = "/app/models/(.*)%.py$",
					target = "/tests/models/test_%1.py"
				},
				{
					pattern = "/tests/(.*)/test_(.*)%.py$",
					target = "/app/%1/%2.py"
				},
				
				-- Python - Jupyter notebooks to Python scripts
				{
					pattern = "/notebooks/(.*)%.ipynb$",
					target = "/src/%1.py"
				},
				{
					pattern = "/src/(.*)%.py$",
					target = "/notebooks/%1.ipynb"
				},

				-- Lua patterns - Neovim plugin structure
				{
					pattern = "/lua/(.*)/(.*)%.lua$",
					target = "/tests/%1/test_%2.lua"
				},
				{
					pattern = "/tests/(.*)/test_(.*)%.lua$",
					target = "/lua/%1/%2.lua"
				},
				
				-- Lua patterns - Neovim config structure
				{
					pattern = "/lua/plugins/(.*)/(.*)%.lua$",
					target = "/lua/config/%1_%2.lua",
					context = "plugin_to_config"
				},
				{
					pattern = "/lua/config/(.*)_(.*)%.lua$",
					target = "/lua/plugins/%1/%2.lua",
					context = "config_to_plugin"
				},
				
				-- Lua patterns - Module to init file
				{
					pattern = "/lua/(.*)/(.*)%.lua$",
					target = "/lua/%1/init.lua",
					context = "module_to_init"
				},
				{
					pattern = "/lua/(.*)/init%.lua$",
					target = "/lua/%1/%1.lua",
					context = "init_to_module"
				},
				
				-- Lua patterns - Neovim runtime structure
				{
					pattern = "/plugin/(.*)%.lua$",
					target = "/lua/%1.lua"
				},
				{
					pattern = "/lua/(.*)%.lua$",
					target = "/plugin/%1.lua"
				},
				
				-- Lua patterns - After plugins
				{
					pattern = "/lua/plugins/(.*)%.lua$",
					target = "/after/plugin/%1.lua"
				},
				{
					pattern = "/after/plugin/(.*)%.lua$",
					target = "/lua/plugins/%1.lua"
				},
				
				-- Lua patterns - Neovim config navigation
				{
					pattern = "/lua/config/autocmds%.lua$",
					target = "/lua/config/keymaps.lua"
				},
				{
					pattern = "/lua/config/keymaps%.lua$",
					target = "/lua/config/options.lua"
				},
				{
					pattern = "/lua/config/options%.lua$",
					target = "/lua/config/autocmds.lua"
				},
				
				-- Lua patterns - Love2D game structure
				{
					pattern = "/src/(.*)%.lua$",
					target = "/tests/test_%1.lua"
				},
				{
					pattern = "/tests/test_(.*)%.lua$",
					target = "/src/%1.lua"
				},
				
				-- Lua patterns - OpenResty/Kong plugins
				{
					pattern = "/kong/plugins/(.*)/handler%.lua$",
					target = "/kong/plugins/%1/schema.lua"
				},
				{
					pattern = "/kong/plugins/(.*)/schema%.lua$",
					target = "/kong/plugins/%1/handler.lua"
				},
			},
			transformers = {
				-- Custom transformer for lowercase conversion
				lowercase = function(inputString)
					return inputString:lower()
				end,
				-- Custom transformer for camelCase to snake_case
				camelToSnake = function(inputString)
					return inputString:gsub("(%u)", "_%1"):lower():gsub("^_", "")
				end,
				-- Custom transformer for snake_case to camelCase
				snakeToCamel = function(inputString)
					return inputString:gsub("_(%w)", function(c) return c:upper() end)
				end,
			},
			style = {
				-- Window border style - matches other plugins in the config
				border = "rounded",
				-- Column separator for the window
				seperator = "|",
				-- Width of the window as percentage (0.7 = 70%)
				width = 0.7,
				-- Minimum height in rows
				minHeight = 2
			},
		})
	end,
	keys = {
		{ "<leader>ll", "<cmd>:Other<cr>", desc = "Open other file" },
		{ "<leader>lh", "<cmd>:OtherSplit<cr>", desc = "Open other file in horizontal split" },
		{ "<leader>lv", "<cmd>:OtherVSplit<cr>", desc = "Open other file in vertical split" },
		{ "<leader>lc", "<cmd>:OtherClear<cr>", desc = "Clear other file cache" },
	},
}
