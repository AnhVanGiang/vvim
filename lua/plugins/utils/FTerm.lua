-- Define the FTerm plugin configuration
return {
	"numToStr/FTerm.nvim",
	config = function()
		-- Load FTerm
		local fTerm = require("FTerm")

		local backgroundDark = "#171717" -- Use your preferred dark background color

		-- Keymaps to toggle FTerm
		-- vim.keymap.set("n", "<C-z>", function()
		-- 	fTerm.toggle()
		-- 	local ns = vim.api.nvim_create_namespace(vim.bo.filetype)
		-- 	vim.api.nvim_win_set_hl_ns(0, ns)
		-- 	vim.api.nvim_set_hl(ns, "Normal", { bg = backgroundDark })
		-- end, {})

		-- vim.keymap.set("t", "<C-z>", function()
		-- 	vim.api.nvim_feedkeys(
		-- 		vim.api.nvim_replace_termcodes("<C-\\><C-n>:lua require('FTerm').toggle()<CR>", false, true, true),
		-- 		"n",
		-- 		false
		-- 	)
		-- end)

		-- FTerm setup
		-- require("FTerm").setup({
		-- 	border = "none",
		-- 	ft = "terminal",
		-- 	dimensions = {
		-- 		height = 0.5,
		-- 		width = 1,
		-- 		x = 0, -- X axis of the terminal window
		-- 		y = 1, -- Y axis of the terminal window
		-- 	},
		-- })

		-- Auto command for terminal background
		-- vim.api.nvim_create_autocmd("FileType", {
		-- 	pattern = "terminal",
		-- 	callback = function()
		-- 		local ns = vim.api.nvim_create_namespace(vim.bo.filetype)
		-- 		vim.api.nvim_win_set_hl_ns(0, ns)
		-- 		vim.api.nvim_set_hl(ns, "Normal", { bg = backgroundDark })
		-- 	end,
		-- })
		--
		-- -- Handle the Unception plugin's edit request
		-- vim.api.nvim_create_autocmd(
		-- 	"User",
		-- 	{
		-- 		pattern = "UnceptionEditRequestReceived",
		-- 		callback = function()
		-- 			-- Toggle the terminal off.
		-- 			fTerm.toggle()
		-- 		end,
		-- 	}
		-- )
	end,
}
