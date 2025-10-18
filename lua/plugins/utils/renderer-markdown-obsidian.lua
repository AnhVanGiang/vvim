-- Writing and navigating an Obsidian vault
return {
	-- Render markdown
	{
		"MeanderingProgrammer/markdown.nvim",
		name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{
				"<leader>m",
				function()
					if vim.bo.filetype == "markdown" then
						require("render-markdown").toggle()
					end
				end,
				desc = "RenderMarkdown: Toggle rendering",
			},
		},
		config = function()
			require("render-markdown").setup({
				enabled = false,
				heading = {
					icons = { "󰎥 ", "󰎨 ", "󰎫 ", "󰎲 ", "󰎯 ", "󰎴 " },
				},
				bullet = {
					icons = { "", "", "◆", "◇" },
				},
				checkbox = {
					unchecked = {
						icon = "󰄱 ",
						highlight = "RenderMarkdownUnchecked",
					},
					checked = {
						icon = "󰱒 ",
						highlight = "RenderMarkdownChecked",
					},
					custom = {
						todo = { raw = "[~]", rendered = "󰥔 ", highlight = "@markup.raw" },
					},
				},
			})
		end,
	},
}
-- return {
--     'MeanderingProgrammer/render-markdown.nvim',
--     dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
--     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
--     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
--     ---@module 'render-markdown'
--     ---@type render.md.UserConfig
--     opts = {},
-- }
