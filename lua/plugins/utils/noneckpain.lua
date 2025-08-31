return {
	"shortcuts/no-neck-pain.nvim",
    enabled = true,
    config = function()
        vim.keymap.set("n", "<leader>np", "<cmd>NoNeckPain<CR>", { desc = "Toggle NoNeckPain", noremap = true, silent = true })
    end,
}
