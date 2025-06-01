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
				find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
				rg_opts = "--color=never --files --hidden --follow -g '!.git'",
				fd_opts = "--color=never --type f --hidden --follow --exclude .git",
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

		-- Key mappings with descriptions
		local opts = { noremap = true, silent = true }

		-- File pickers
		vim.keymap.set("n", "<leader>ff", fzf.files, vim.tbl_extend("force", opts, { desc = "Find files" }))
		vim.keymap.set("n", "<leader>fg", fzf.git_files, vim.tbl_extend("force", opts, { desc = "Find git files" }))
		vim.keymap.set("n", "<leader>fb", fzf.buffers, vim.tbl_extend("force", opts, { desc = "Find buffers" }))
		vim.keymap.set("n", "<leader>fo", fzf.oldfiles, vim.tbl_extend("force", opts, { desc = "Find recent files" }))
		vim.keymap.set("n", "<leader>fq", fzf.quickfix, vim.tbl_extend("force", opts, { desc = "Find quickfix items" }))
		vim.keymap.set(
			"n",
			"<leader>fl",
			fzf.loclist,
			vim.tbl_extend("force", opts, { desc = "Find location list items" })
		)

		-- Search
		vim.keymap.set("n", "<leader>rg", fzf.live_grep, vim.tbl_extend("force", opts, { desc = "Live grep" }))
		vim.keymap.set("n", "<leader>rG", fzf.grep, vim.tbl_extend("force", opts, { desc = "Grep with input" }))
		vim.keymap.set(
			"n",
			"<leader>rw",
			fzf.grep_cword,
			vim.tbl_extend("force", opts, { desc = "Grep word under cursor" })
		)
		vim.keymap.set(
			"n",
			"<leader>rW",
			fzf.grep_cWORD,
			vim.tbl_extend("force", opts, { desc = "Grep WORD under cursor" })
		)
		vim.keymap.set(
			"v",
			"<leader>rg",
			fzf.grep_visual,
			vim.tbl_extend("force", opts, { desc = "Grep visual selection" })
		)
		vim.keymap.set(
			"n",
			"<leader>rb",
			fzf.lgrep_curbuf,
			vim.tbl_extend("force", opts, { desc = "Live grep current buffer" })
		)
		vim.keymap.set(
			"n",
			"<leader>rB",
			fzf.live_grep_glob,
			vim.tbl_extend("force", opts, { desc = "Live grep with glob pattern" })
		)
		vim.keymap.set("n", "<leader>rr", fzf.resume, vim.tbl_extend("force", opts, { desc = "Resume last search" }))

		-- Git
		vim.keymap.set("n", "<leader>gc", fzf.git_commits, vim.tbl_extend("force", opts, { desc = "Git commits" }))
		vim.keymap.set(
			"n",
			"<leader>gC",
			fzf.git_bcommits,
			vim.tbl_extend("force", opts, { desc = "Git buffer commits" })
		)
		vim.keymap.set("n", "<leader>gb", fzf.git_branches, vim.tbl_extend("force", opts, { desc = "Git branches" }))
		vim.keymap.set("n", "<leader>gs", fzf.git_status, vim.tbl_extend("force", opts, { desc = "Git status" }))
		vim.keymap.set("n", "<leader>gS", fzf.git_stash, vim.tbl_extend("force", opts, { desc = "Git stash" }))

		-- LSP
		vim.keymap.set(
			"n",
			"<leader>lr",
			fzf.lsp_references,
			vim.tbl_extend("force", opts, { desc = "LSP references" })
		)
		vim.keymap.set(
			"n",
			"<leader>ld",
			fzf.lsp_definitions,
			vim.tbl_extend("force", opts, { desc = "LSP definitions" })
		)
		vim.keymap.set(
			"n",
			"<leader>lD",
			fzf.lsp_declarations,
			vim.tbl_extend("force", opts, { desc = "LSP declarations" })
		)
		vim.keymap.set(
			"n",
			"<leader>lt",
			fzf.lsp_typedefs,
			vim.tbl_extend("force", opts, { desc = "LSP type definitions" })
		)
		vim.keymap.set(
			"n",
			"<leader>li",
			fzf.lsp_implementations,
			vim.tbl_extend("force", opts, { desc = "LSP implementations" })
		)
		vim.keymap.set(
			"n",
			"<leader>ls",
			fzf.lsp_document_symbols,
			vim.tbl_extend("force", opts, { desc = "LSP document symbols" })
		)
		vim.keymap.set(
			"n",
			"<leader>lS",
			fzf.lsp_workspace_symbols,
			vim.tbl_extend("force", opts, { desc = "LSP workspace symbols" })
		)
		vim.keymap.set(
			"n",
			"<leader>la",
			fzf.lsp_code_actions,
			vim.tbl_extend("force", opts, { desc = "LSP code actions" })
		)
		vim.keymap.set(
			"n",
			"<leader>le",
			fzf.diagnostics_document,
			vim.tbl_extend("force", opts, { desc = "LSP document diagnostics" })
		)
		vim.keymap.set(
			"n",
			"<leader>lE",
			fzf.diagnostics_workspace,
			vim.tbl_extend("force", opts, { desc = "LSP workspace diagnostics" })
		)

		-- Vim/Neovim
		vim.keymap.set("n", "<leader>vh", fzf.help_tags, vim.tbl_extend("force", opts, { desc = "Help tags" }))
		vim.keymap.set("n", "<leader>vm", fzf.man_pages, vim.tbl_extend("force", opts, { desc = "Man pages" }))
		vim.keymap.set("n", "<leader>vc", fzf.colorschemes, vim.tbl_extend("force", opts, { desc = "Colorschemes" }))
		vim.keymap.set("n", "<leader>vC", fzf.commands, vim.tbl_extend("force", opts, { desc = "Commands" }))
		vim.keymap.set(
			"n",
			"<leader>vH",
			fzf.command_history,
			vim.tbl_extend("force", opts, { desc = "Command history" })
		)
		vim.keymap.set(
			"n",
			"<leader>vs",
			fzf.search_history,
			vim.tbl_extend("force", opts, { desc = "Search history" })
		)
		vim.keymap.set("n", "<leader>vk", fzf.keymaps, vim.tbl_extend("force", opts, { desc = "Keymaps" }))
		vim.keymap.set("n", "<leader>vr", fzf.registers, vim.tbl_extend("force", opts, { desc = "Registers" }))
		vim.keymap.set("n", "<leader>va", fzf.autocmds, vim.tbl_extend("force", opts, { desc = "Autocommands" }))
		vim.keymap.set("n", "<leader>vj", fzf.jumps, vim.tbl_extend("force", opts, { desc = "Jump list" }))
		vim.keymap.set("n", "<leader>vM", fzf.marks, vim.tbl_extend("force", opts, { desc = "Marks" }))
		vim.keymap.set("n", "<leader>vt", fzf.tags, vim.tbl_extend("force", opts, { desc = "Tags" }))
		vim.keymap.set("n", "<leader>vT", fzf.btags, vim.tbl_extend("force", opts, { desc = "Buffer tags" }))

		-- Misc
		vim.keymap.set(
			"n",
			"<leader>:",
			fzf.command_history,
			vim.tbl_extend("force", opts, { desc = "Command history" })
		)
		vim.keymap.set("n", "<leader>/", fzf.search_history, vim.tbl_extend("force", opts, { desc = "Search history" }))
		vim.keymap.set(
			"n",
			"<leader>?",
			fzf.builtin,
			vim.tbl_extend("force", opts, { desc = "FzfLua builtin commands" })
		)
	end,
}
