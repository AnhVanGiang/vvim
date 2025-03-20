return {
	"jackMort/ChatGPT.nvim",
	enabled = false,
	event = "VeryLazy",
	config = function()
		require("chatgpt").setup({
			-- this config assumes you have OPENAI_API_KEY environment variable set
			openai_params = {
				-- NOTE: model can be a function returning the model name
				-- this is useful if you want to change the model on the fly
				-- using commands
				-- Example:
				-- model = function()
				--     if some_condition() then
				--         return "gpt-4-1106-preview"
				--     else
				--         return "gpt-3.5-turbo"
				--     end
				-- end,
				model = "o3-mini-2025-01-31",
				api_key_cmd = "cat ~/.openai_key",
				frequency_penalty = 0,
				presence_penalty = 0,
				max_tokens = 200000,
				temperature = 0.2,
				top_p = 0.1,
				n = 1,
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim", -- optional
		"nvim-telescope/telescope.nvim",
	},
}
