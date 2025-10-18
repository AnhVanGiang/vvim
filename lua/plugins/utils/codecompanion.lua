local gemini_api_key = vim.env.GEMINI_API_KEY or os.getenv("GEMINI_API_KEY")

if not gemini_api_key or gemini_api_key == "" then
  -- Warn non-intrusively if the key is missing
  vim.schedule(function()
    pcall(vim.notify, "GEMINI_API_KEY is not set for CodeCompanion", vim.log.levels.WARN)
  end)
end

return {
	"olimorris/codecompanion.nvim",
	opts = {},
	enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		-- "ravitemer/mcphub.nvim",
	},
	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "gemini",
				},
				inline = {
					adapter = "gemini",
				},
				cmd = {
					adapter = "gemini",
				},
			},
			adapters = {
				gemini = {
					env = {
						GEMINI_API_KEY = gemini_api_key,
					},
				},
			},
		})
	end,
}
