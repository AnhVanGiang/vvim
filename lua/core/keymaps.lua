---@module [TODO:description]
---@author [TODO:description]
---@license [TODO:description]

-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
-- Keymaps configuration file: keymaps of neovim and plugins.
-- ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
local opts = { noremap = true, silent = true }

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Basic key bindings
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Maintain visual mode after shifting
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

vim.keymap.set("n", "x", '"_x')
-- Remove shift+tab default behavior
-- vim.keymap.del('i', '<S-Tab>')
-- Telescope find hidden files
-- vim.keymap.set('n', '<leader>fh', function()
--   require('telescope.builtin').find_files({ hidden = true })
-- end, { desc = "Find hidden files" })
-- Go down/up soft-wrapped lines instead of "real" lines
-- vim.keymap.set("n", "j", "gj", default_opts)
-- vim.keymap.set("n", "k", "gk", default_opts)

-- Keep the cursor line in the middle of the screen
-- vim.keymap.set("n", "j", "jzz", default_opts)
-- vim.keymap.set("n", "k", "kzz", default_opts)

-- Window navigation
vim.keymap.set("n", "<A-h>", "<C-w>h", opts)
vim.keymap.set("n", "<A-j>", "<C-w>j", opts)
vim.keymap.set("n", "<A-k>", "<C-w>k", opts)
vim.keymap.set("n", "<A-l>", "<C-w>l", opts)

-- load the session for the current directory
vim.keymap.set("n", "<leader>qs", function()
	require("persistence").load()
end, { desc = "Load session for current directory" })

-- select a session to load
vim.keymap.set("n", "<leader>qS", function()
	require("persistence").select()
end, { desc = "Select session to load" })

-- load the last session
vim.keymap.set("n", "<leader>ql", function()
	require("persistence").load({ last = true })
end, { desc = "Load last session" })

-- stop Persistence => session won't be saved on exit
vim.keymap.set("n", "<leader>qd", function()
	require("persistence").stop()
end, { desc = "Stop session persistence" })
-- In insert mode, <Alt>+h,j,k,l becomes arrows
vim.keymap.set("i", "<A-h>", "<Left>", opts)
vim.keymap.set("i", "<A-j>", "<Down>", opts)
vim.keymap.set("i", "<A-k>", "<Up>", opts)
vim.keymap.set("i", "<A-l>", "<Right>", opts)

-- Window resize
vim.keymap.set("n", "<A-Up>", "<C-w>+", opts)
vim.keymap.set("n", "<A-Down>", "<C-w>-", opts)
vim.keymap.set("n", "<A-Left>", "<C-w><", opts)
vim.keymap.set("n", "<A-Right>", "<C-w>>", opts)

-- Window swapping
vim.keymap.set("n", "<A-S-h>", "<C-w>h<C-w>x", opts)
vim.keymap.set("n", "<A-S-j>", "<C-w>j<C-w>x", opts)
vim.keymap.set("n", "<A-S-k>", "<C-w>k<C-w>x", opts)
vim.keymap.set("n", "<A-S-l>", "<C-w>l<C-w>x", opts)

-- Navigation from terminal
-- vim.keymap.set("t", "<C-esc>", [[<C-\><C-n>]], opts)
vim.keymap.set("t", "<A-h>", [[<C-\><C-n><C-w>h]], opts)
vim.keymap.set("t", "<A-j>", [[<C-\><C-n><C-w>j]], opts)
vim.keymap.set("t", "<A-k>", [[<C-\><C-n><C-w>k]], opts)
vim.keymap.set("t", "<A-l>", [[<C-\><C-n><C-w>l]], opts)
vim.keymap.set("n", "}", "}^", { noremap = true })
vim.keymap.set("n", "{", "{^", { noremap = true })
-- Toggle conceal level between 0 and 2
-- vim.keymap.set("n", "<leader>cc",
--     function()
--         vim.opt_local.conceallevel = math.abs(vim.opt_local.conceallevel._value - 2)
--     end,
--     { desc = "Toggle conceal level in the current buffer", noremap = true, silent = true }
-- )

-- Splits
vim.keymap.set("n", "<leader>vs", "<cmd>vsplit<CR>", { desc = "Vertical split" })
-- vim.keymap.set("n", "<leader>ss", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Close split
vim.keymap.set("n", "<leader>qq", "<cmd>q<CR>", { desc = "Close buffer" })
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Function key bindings
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- <F1>: Show help
vim.keymap.set("n", "<F1>", "<cmd>Telescope help_tags<CR>", opts)
-- <S-F1>: Show keymaps
vim.keymap.set("n", "<F13>", "<cmd>Telescope keymaps<CR>", opts)

-- <F2>: Rename (check lspconfig)
vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
-- <S-F2>: Show task list
vim.keymap.set("n", "<F14>", "<cmd>TodoTelescope<CR>", opts)

-- <F3>: Show file tree explorer
-- vim.keymap.set("n", "<F3>", "<cmd>NvimTreeToggle<CR>", default_opts)
vim.keymap.set("n", "<space>nn", "<cmd>Neotree toggle float reveal<CR>", opts)
-- <F3>: Show file tree at the current file
vim.keymap.set("n", "<F15>", "<cmd>Neotree reveal<CR>", opts)

-- <F4>: Show tags of current buffer
-- vim.keymap.set("n", "<F4>", ":Telescope current_buffer_tags<CR>", default_opts)
vim.keymap.set("n", "<F4>", "<cmd>Outline!<CR>", opts)
vim.keymap.set("n", "<space>o", "<cmd>OutlineFocusOutline<CR>", opts)
vim.keymap.set("n", "<F4>", "<cmd>Outline!<CR>", opts)
-- <S-F4>: Show diagnostics
vim.keymap.set("n", "<F16>", "<cmd>Telescope diagnostics<CR>", opts)
-- <S-F4>: Generate tags
-- vim.keymap.set("n", "<F16>", ":!ctags -R --links=no . <CR>", default_opts)

-- <F5>: Show and switch buffer
vim.keymap.set("n", "<F5>", "<cmd>Telescope buffers<CR>", opts)
-- <S-F5>: Show and switch tab
vim.keymap.set("n", "<F17>", "<cmd>tabs<CR>", opts)

-- <F6>: Prev buffer
vim.keymap.set("n", "<F6>", "<cmd>BufferPrevious<CR>", opts)
-- <S-F6>: Prev tab
vim.keymap.set("n", "<F18>", "<cmd>tabprevious<CR>", opts)

-- <F7>: Next buffer
vim.keymap.set("n", "<F7>", "<cmd>BufferNext<CR>", opts)
-- <S-F7>: Next tab
vim.keymap.set("n", "<F19>", "<cmd>tabnext<CR>", opts)

-- <F8>: Close current buffer and switch to previous buffer
vim.keymap.set("n", "<F8>", "<cmd>BufferClose<CR>", opts)
-- <S-F8>: Close current tab
vim.keymap.set("n", "<F20>", "<cmd>tabclose<CR>", opts)

-- <F9>: Remove trailing spaces
vim.keymap.set("n", "<F9>", [[<cmd>%s/\s\+$//e<CR>]], opts)
-- <S-F9>: Clear registers
vim.keymap.set("n", "<F21>", "<cmd>ClearAllRegisters<CR>", opts)

-- <F10>: Run make file
vim.keymap.set("n", "<F10>", "<cmd>make<CR>", opts)
-- <S-F10>: Run make clean
vim.keymap.set("n", "<F22>", "<cmd>make clean<CR>", opts)

-- <F11>: Toggle zoom the current window (from custom functions)
vim.keymap.set("n", "<F11>", function()
	require("snacks").zen.zoom()
end, opts)
-- <S-F11>: Toggle colorizer
vim.keymap.set("n", "<F23>", "<cmd>ColorizerToggle<CR>", opts)

-- <F12>: Toggle relative number
vim.keymap.set("n", "<F12>", "<cmd>set nu rnu!<CR>", opts)
-- <S-F11>: Toggle welcome screen
vim.keymap.set("n", "<F24>", function()
	require("snacks").dashboard()
end, opts)

-- Shortcut to generate ctags
vim.keymap.set("n", "<leader>ct", ":!ctags -R .<CR>", { desc = "Generate ctags" })

-- Equalize Buffers
vim.keymap.set("n", "<leader>E", "<cmd>WindowsEqualize<CR>", { desc = "Equalize Buffers" })

-- Maximize current buffer
vim.keymap.set("n", "<leader>M", "<cmd>WindowsMaximize<CR>", { desc = "Maximize Buffer" })

-- Blackhole change
vim.keymap.set("n", "c", '"_c', { noremap = true })
-- Force close current buffer
vim.keymap.set("n", "<space>qb", "<cmd>BD!<CR>", { desc = "Force close current buffer" })
vim.keymap.set("n", "<space>qa", "<cmd>BufferCloseAllButVisible<CR>", { desc = "Force close all buffers but visible" })
-- Run Python file
vim.keymap.set("n", "<leader>rp", "<cmd>!python3 %<CR>", { desc = "Run Python file" })

vim.api.nvim_set_keymap(
	"n",
	"<leader>rpf",
	":w<CR>:lua RunPythonInFloatingTerm()<CR>",
	{ desc = "Run python in floating terminal", noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<space>pc",
	"o```{python}<CR><CR>```<Esc>k",
	{ noremap = true, silent = true, desc = "Add python cell" }
)
function RunPythonInFloatingTerm()
	-- Get the current buffer's file path
	local file = vim.fn.expand("%")

	-- Set up the floating window options
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "single", -- You can change this to "rounded", "double", etc.
	}

	-- Create the floating terminal
	local buf = vim.api.nvim_create_buf(false, true) -- Create a scratch buffer
	local win = vim.api.nvim_open_win(buf, true, opts) -- Open the buffer in a floating window

	-- Start a terminal in the buffer
	vim.fn.termopen("python3 " .. file)

	-- Optional: Close the terminal with "q"
	vim.api.nvim_buf_set_keymap(buf, "t", "q", "<C-\\><C-n>:close<CR>", { noremap = true, silent = true })
end

local function new_terminal(lang)
	vim.cmd("vsplit term://" .. lang)
end

local function new_terminal_python()
	new_terminal("python")
end

local function new_terminal_r()
	new_terminal("R --no-save")
end

local function new_terminal_ipython()
	new_terminal("ipython --no-confirm-exit")
end

local function new_terminal_julia()
	new_terminal("julia")
end

local function new_terminal_shell()
	new_terminal("$SHELL")
end

local function send_cell()
	if vim.b["quarto_is_r_mode"] == nil then
		vim.fn["slime#send_cell"]()
		return
	end
	if vim.b["quarto_is_r_mode"] == true then
		vim.g.slime_python_ipython = 0
		local is_python = require("otter.tools.functions").is_otter_language_context("python")
		if is_python and not vim.b["reticulate_running"] then
			vim.fn["slime#send"]("reticulate::repl_python()" .. "\r")
			vim.b["reticulate_running"] = true
		end
		if not is_python and vim.b["reticulate_running"] then
			vim.fn["slime#send"]("exit" .. "\r")
			vim.b["reticulate_running"] = false
		end
		vim.fn["slime#send_cell"]()
	end
end
--
vim.keymap.set("n", "<leader><cr>", send_cell, { desc = "run code cell" })
-- vim.keymap.set("n", "<leader>c", group = "[c]ode / [c]ell / [c]hunk" ),
vim.keymap.set("n", "<leader>ci", new_terminal_ipython, { desc = "new [i]python terminal" })
-- vim.keymap.set("n", "<leader>cj", new_terminal_julia, desc = "new [j]ulia terminal" ),
-- vim.keymap.set("n", "<leader>cn", new_terminal_shell, desc = "[n]ew terminal with shell" ),
vim.keymap.set("n", "<leader>cp", new_terminal_python, { desc = "new [p]ython terminal" })

vim.keymap.set(
	"n",
	"<leader>tr",
	":lua require('neotest').run.run()<CR>",
	{ noremap = true, silent = true, desc = "Run Neotest" }
)
vim.keymap.set(
	"n",
	"<leader>tf",
	":lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
	{ noremap = true, silent = true, desc = "Run Neotest on current file" }
)
vim.keymap.set(
	"n",
	"<leader>ts",
	":lua require('neotest').run.stop()<CR>",
	{ noremap = true, silent = true, desc = "Stop Neotest" }
)
vim.keymap.set(
	"n",
	"<leader>to",
	":lua require('neotest').summary.toggle()<CR>",
	{ noremap = true, silent = true, desc = "Toggle Neotest summary" }
)
vim.keymap.set(
	"n",
	"<leader>tl",
	":lua require('neotest').output.open({ enter = true })<CR>",
	{ noremap = true, silent = true, desc = "Open Neotest output" }
)
vim.keymap.set(
	"n",
	"<leader>ta",
	"<cmd>Neotest attach<CR>",
	{ noremap = true, silent = true, desc = "Attach to Neotest" }
)
vim.keymap.set(
	"n",
	"<leader>top",
	"<cmd>Neotest output-panel",
	{ noremap = true, silent = true, desc = "Toggle Neotest output panel" }
)

-- See diagnostics in float window
vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end, { desc = "Open diagnostics in quickfix list" })

vim.keymap.set("n", "<leader>1", ":ToggleTerm 1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>2", ":ToggleTerm 2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>3", ":ToggleTerm 3<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>4", ":ToggleTerm 4<CR>", { noremap = true, silent = true })

-- Clear search highlight
-- vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { silent = true })

-- Define OpenFloatingTerminal function using native terminal
function OpenFloatingTerminal()
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)
	local opts = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal",
		border = "curved",
	}

	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, opts)
	vim.fn.termopen(vim.o.shell)
	vim.cmd("startinsert")
end

vim.keymap.set(
	"n",
	"<leader>ft",
	":lua OpenFloatingTerminal()<CR>",
	{ noremap = true, silent = true, desc = "Open floating terminal" }
)
-- movement
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true, desc = "Open a new tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close the current tab" })
vim.keymap.set("n", "<leader>ts", ":tab split<CR>", { noremap = true, silent = true, desc = "Split tab" })
-- vim.api.nvim_set_keymap('n', '<leader>tp', ':tabprevious<CR>', { noremap = true, silent = true, desc = "Go to the previous tab" })
-- vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnext<CR>', { noremap = true, silent = true, desc = "Go to the next tab" })
local function add_cell_marker()
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0)) -- Get the current cursor position (1-indexed)
	local buf = vim.api.nvim_get_current_buf() -- Get the current buffer

	-- Insert empty line above, "# %%", and empty line below
	vim.api.nvim_buf_set_lines(buf, row - 1, row, false, { "", "# %%", "" })

	-- Move the cursor to the line containing "# %%" for convenience
	vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
end

vim.keymap.set("n", "<space>ac", add_cell_marker, { noremap = true, desc = "Add # %% to the current or new line" })

vim.keymap.set("n", "<space>d", vim.diagnostic.open_float, { noremap = true, silent = true })

-- Rabbit
vim.keymap.set("n", "<space>R", ":Rabbit trail<CR>", { noremap = true, silent = true, desc = "Rabbit" })
-- vim.keymap.set("n", "<leader>rh", ":Rabbit history<CR>", { noremap = true, silent = true, desc="Rabbit" })
-- vim.api.nvim_set_keymap(
--   'n',
--   '<leader>Ag',
--   ':AiderOpen --model openai/o3-mini-2025-01-31<CR>',G
--   { noremap = true, silent = true }
-- )

-- vim.api.nvim_set_keymap('n', '<leader>Ag', ':AiderOpen --model o3-mini<CR>', {noremap = true, silent = true})
