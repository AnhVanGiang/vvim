-- Neovide settings if available
if vim.g.neovide then
    vim.g.neovide_refresh_rate = 60
    vim.env.PATH = vim.env.PATH .. ":/usr/local/bin:/opt/homebrew/bin"
	-- Set GUI  font
	vim.o.guifont = "JetBrainsMono Nerd Font:h15"

	-- Cursor effect
	vim.g.neovide_cursor_vfx_mode = "railgun"

	-- Allow MacOS cmd+c cmd+v for copy/paste
	vim.keymap.set("v", "<D-c>", '"+y') -- Copy
	vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
	vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
	vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
	vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode

	-- Allow Alt key in MacOS
	vim.g.neovide_input_macos_option_key_is_meta = "both"
	vim.g.neovide_position_animation_length = 0
	vim.g.neovide_cursor_animation_length = 0.00
	vim.g.neovide_cursor_trail_size = 0
	vim.g.neovide_cursor_animate_in_insert_mode = false
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_scroll_animation_far_lines = 0
	vim.g.neovide_scroll_animation_length = 0.00i

	-- Allow clipboard copy paste in neovi
end


vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
