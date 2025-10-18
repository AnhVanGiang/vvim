return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local fzf = require("fzf-lua")

		fzf.setup({
			-- Global settings
			winopts = {
				height = 0.85,
				width = 0.80,
				row = 0.35,
				col = 0.50,
				border = "rounded",
				preview = {
					default = "bat",
					border = "border",
					wrap = "nowrap",
					hidden = "nohidden",
					vertical = "down:45%",
					horizontal = "right:60%",
					layout = "flex",
					flip_columns = 120,
				},
			},

			-- Fzf options
			fzf_opts = {
				["--ansi"] = "",
				["--info"] = "inline",
				["--height"] = "100%",
				["--layout"] = "reverse",
				["--border"] = "none",
			},

			-- Files configuration
			files = {
				prompt = "Files❯ ",
				multiprocess = true,
				git_icons = true,
				file_icons = true,
				color_icons = true,
				cmd = "fd --type f --hidden --follow --exclude .git --exec-batch ls -latu {} + | sort -k6,8 -r | awk '{print $NF}'",
				-- Comment out find_opts, rg_opts, fd_opts when using custom cmd
			},
			-- Grep configuration
			grep = {
				prompt = "Rg❯ ",
				input_prompt = "Grep For❯ ",
				multiprocess = true,
				git_icons = true,
				file_icons = true,
				color_icons = true,
				rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512",
				grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
			},

			-- Buffers configuration
			buffers = {
				prompt = "Buffers❯ ",
				file_icons = true,
				color_icons = true,
				sort_lastused = true,
			},

			-- Git configuration
			git = {
				files = {
					prompt = "GitFiles❯ ",
					cmd = "git ls-files --exclude-standard",
					multiprocess = true,
					git_icons = true,
					file_icons = true,
					color_icons = true,
				},
				status = {
					prompt = "GitStatus❯ ",
					cmd = "git status --porcelain=v1",
					file_icons = true,
					git_icons = true,
					color_icons = true,
				},
				commits = {
					prompt = "Commits❯ ",
					cmd = "git log --color=always --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%an%C(reset) %s' --date=short",
				},
				bcommits = {
					prompt = "BCommits❯ ",
					cmd = "git log --color=always --pretty=format:'%C(yellow)%h%C(reset) %C(blue)%ad%C(reset) %C(green)%an%C(reset) %s' --date=short",
				},
				branches = {
					prompt = "Branches❯ ",
					cmd = "git branch --all --color=always",
				},
			},

			-- LSP configuration
			lsp = {
				prompt_postfix = "❯ ",
				cwd_only = false,
				async_or_timeout = 5000,
				file_icons = true,
				git_icons = false,
				color_icons = true,
			},
		})

		-- Key mappings matching snacks keymaps
		local opts = { noremap = true, silent = true }

		-- Top Pickers & Explorer (commented out - using snacks)
		-- vim.keymap.set("n", "<leader><space>", function()
        --     require("fzf-lua-enchanted-files").files()
		-- end, vim.tbl_extend("force", opts, { desc = "Smart Find Files" }))
		-- vim.keymap.set("n", "<leader>,", function()
		-- 	fzf.buffers({
		-- 		sort_lastused = true,
		-- 		ignore_current_buffer = true,
		-- 	})
		-- end, vim.tbl_extend("force", opts, { desc = "Buffers" }))
		vim.keymap.set("n", "<leader>/", fzf.live_grep, vim.tbl_extend("force", opts, { desc = "Grep" }))
		-- vim.keymap.set("n", "<leader>:", fzf.command_history, vim.tbl_extend("force", opts, { desc = "Command History" }))
		
		-- find (commented out - using snacks)
		-- vim.keymap.set("n", "<leader>fb", fzf.buffers, vim.tbl_extend("force", opts, { desc = "Buffers" }))
		-- vim.keymap.set("n", "<leader>fc", function() fzf.files({ cwd = vim.fn.stdpath("config") }) end, vim.tbl_extend("force", opts, { desc = "Find Config File" }))
		-- vim.keymap.set("n", "<leader>ff", function() 
		-- 	fzf.files({
		-- 		cmd = "fd --type f --hidden --no-ignore --exclude .git",
		-- 		prompt = "All Files> ",
		-- 	})
		-- end, vim.tbl_extend("force", opts, { desc = "Find All Files (including hidden)" }))
		-- vim.keymap.set("n", "<leader>fg", fzf.git_files, vim.tbl_extend("force", opts, { desc = "Find Git Files" }))
		-- vim.keymap.set("n", "<leader>fr", fzf.oldfiles, vim.tbl_extend("force", opts, { desc = "Recent" }))
		
		-- git (commented out - using snacks)
		-- vim.keymap.set("n", "<leader>gb", fzf.git_branches, vim.tbl_extend("force", opts, { desc = "Git Branches" }))
		-- vim.keymap.set("n", "<leader>gl", fzf.git_commits, vim.tbl_extend("force", opts, { desc = "Git Log" }))
		-- vim.keymap.set("n", "<leader>gL", fzf.git_bcommits, vim.tbl_extend("force", opts, { desc = "Git Log Line" }))
		-- vim.keymap.set("n", "<leader>gs", fzf.git_status, vim.tbl_extend("force", opts, { desc = "Git Status" }))
		-- vim.keymap.set("n", "<leader>gS", fzf.git_stash, vim.tbl_extend("force", opts, { desc = "Git Stash" }))
		-- vim.keymap.set("n", "<leader>gf", fzf.git_bcommits, vim.tbl_extend("force", opts, { desc = "Git Log File" }))
		
		-- Grep (commented out - using snacks)
		-- vim.keymap.set("n", "<leader>sb", fzf.blines, vim.tbl_extend("force", opts, { desc = "Buffer Lines" }))
		-- vim.keymap.set("n", "<leader>sB", fzf.grep_curbuf, vim.tbl_extend("force", opts, { desc = "Grep Open Buffers" }))
		-- vim.keymap.set("n", "<leader>sg", fzf.live_grep, vim.tbl_extend("force", opts, { desc = "Grep" }))
		-- vim.keymap.set("n", "<leader>sw", fzf.grep_cword, vim.tbl_extend("force", opts, { desc = "Visual selection or word" }))
		-- vim.keymap.set("v", "<leader>sw", fzf.grep_visual, vim.tbl_extend("force", opts, { desc = "Visual selection or word" }))
		
		-- search (commented out - using snacks)
		-- vim.keymap.set("n", '<leader>s"', fzf.registers, vim.tbl_extend("force", opts, { desc = "Registers" }))
		-- vim.keymap.set("n", '<leader>s/', fzf.search_history, vim.tbl_extend("force", opts, { desc = "Search History" }))
		-- vim.keymap.set("n", "<leader>sa", fzf.autocmds, vim.tbl_extend("force", opts, { desc = "Autocmds" }))
		-- vim.keymap.set("n", "<leader>sc", fzf.command_history, vim.tbl_extend("force", opts, { desc = "Command History" }))
		-- vim.keymap.set("n", "<leader>sC", fzf.commands, vim.tbl_extend("force", opts, { desc = "Commands" }))
		-- vim.keymap.set("n", "<leader>sd", fzf.diagnostics_document, vim.tbl_extend("force", opts, { desc = "Diagnostics" }))
		-- vim.keymap.set("n", "<leader>sD", fzf.diagnostics_workspace, vim.tbl_extend("force", opts, { desc = "Buffer Diagnostics" }))
		-- vim.keymap.set("n", "<leader>sh", fzf.help_tags, vim.tbl_extend("force", opts, { desc = "Help Pages" }))
		-- vim.keymap.set("n", "<leader>sH", fzf.highlights, vim.tbl_extend("force", opts, { desc = "Highlights" }))
		-- vim.keymap.set("n", "<leader>sj", fzf.jumps, vim.tbl_extend("force", opts, { desc = "Jumps" }))
		-- vim.keymap.set("n", "<leader>sk", fzf.keymaps, vim.tbl_extend("force", opts, { desc = "Keymaps" }))
		-- vim.keymap.set("n", "<leader>sl", fzf.loclist, vim.tbl_extend("force", opts, { desc = "Location List" }))
		-- vim.keymap.set("n", "<leader>sm", fzf.marks, vim.tbl_extend("force", opts, { desc = "Marks" }))
		-- vim.keymap.set("n", "<leader>sM", fzf.man_pages, vim.tbl_extend("force", opts, { desc = "Man Pages" }))
		-- vim.keymap.set("n", "<leader>sq", fzf.quickfix, vim.tbl_extend("force", opts, { desc = "Quickfix List" }))
		-- vim.keymap.set("n", "<leader>sR", fzf.resume, vim.tbl_extend("force", opts, { desc = "Resume" }))
		-- vim.keymap.set("n", "<leader>uC", fzf.colorschemes, vim.tbl_extend("force", opts, { desc = "Colorschemes" }))
		
		-- LSP (commented out - using snacks)
		-- vim.keymap.set("n", "gd", fzf.lsp_definitions, vim.tbl_extend("force", opts, { desc = "Goto Definition" }))
		-- vim.keymap.set("n", "gD", fzf.lsp_declarations, vim.tbl_extend("force", opts, { desc = "Goto Declaration" }))
		-- vim.keymap.set("n", "gr", fzf.lsp_references, vim.tbl_extend("force", opts, { desc = "References", nowait = true }))
		-- vim.keymap.set("n", "gI", fzf.lsp_implementations, vim.tbl_extend("force", opts, { desc = "Goto Implementation" }))
		-- vim.keymap.set("n", "gy", fzf.lsp_typedefs, vim.tbl_extend("force", opts, { desc = "Goto T[y]pe Definition" }))
		-- vim.keymap.set("n", "<leader>ss", fzf.lsp_document_symbols, vim.tbl_extend("force", opts, { desc = "LSP Symbols" }))
	end,
}
