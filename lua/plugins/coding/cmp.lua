-- Code completion
return {
	"hrsh7th/nvim-cmp", -- code completion
	enabled = false,
	event = { "CmdlineEnter", "InsertEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-calc",
		"onsails/lspkind-nvim",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

		-- Navigate to the next item in the list (only in cmp menu)
		local next_item = function()
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp.complete() -- Trigger completion if not visible
			end
		end

		-- Navigate to the previous item in the list (only in cmp menu)
		local prev_item = function()
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp.complete() -- Trigger completion if not visible
			end
		end

		-- Check if a backwards jump is possible in LuaSnip
		local has_luasnip_jump_backwards = function()
			return luasnip.jumpable(-1)
		end

		-- Function to handle snippet jump or fallback
		local handle_snippet_jump_or_fallback = function(fallback, direction)
			if luasnip.expand_or_jumpable(direction) then
				luasnip.expand_or_jump(direction)
			else
				fallback()
			end
		end

		-- Main config
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.scroll_docs(-4),
				-- ["<C-j>"] = cmp.mapping.scroll_docs(4),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-c>"] = cmp.mapping.abort(),
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				-- ["<Tab>"] = cmp.mapping(function(fallback)
				-- 	handle_snippet_jump_or_fallback(next_item, 1) -- Use next_item as fallback
				-- end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if has_luasnip_jump_backwards() then
						luasnip.jump(-1)
					else
						prev_item() -- Call prev_item if no backward jump
					end
				end, { "i", "s" }),
				["<C-n>"] = cmp.mapping(next_item, { "i", "s" }),
				["<C-p>"] = cmp.mapping(prev_item, { "i", "s" }),
			}),
			sources = cmp.config.sources({
                -- {name = "codeium"},
				{ name = "supermaven"},
				{ name = "nvim_lsp"},
				{ name = "buffer",},
				{ name = "path" },
				-- { name = "luasnip" },
			}),
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol_text",
					preset = "codicons",
				}),
			},
			experimental = {
				ghost_text = {
					hl_group = "CmpGhostText",
				},
			},
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.kind,
					cmp.config.compare.recently_used,
				},
			},
		})

		-- `/` cmdline setup.
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		-- Load snippets for luasnip
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
