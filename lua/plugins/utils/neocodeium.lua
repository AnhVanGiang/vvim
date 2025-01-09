return {
	"monkoose/neocodeium",
	event = "VeryLazy",
    enabled=true,
	config = function()
		local neocodeium = require("neocodeium")
		neocodeium.setup()
		vim.keymap.set("i", "<Tab>", function()
			require("neocodeium").accept()
		end)
		-- vim.keymap.set("i", "<A-w>", function()
		-- 	require("neocodeium").accept_word()
		-- end)
		-- vim.keymap.set("i", "<A-a>", function()
		-- 	require("neocodeium").accept_line()
		-- end)
		-- vim.keymap.set("i", "<C-n>", function()
		-- 	require("neocodeium").cycle_or_complete()
		-- end)
		-- vim.keymap.set("i", "<C-p>", function()
		-- 	require("neocodeium").cycle_or_complete(-1)
		-- end)
		-- vim.keymap.set("i", "<A-c>", function()
		-- 	require("neocodeium").clear()
		-- end)
	end,
}
