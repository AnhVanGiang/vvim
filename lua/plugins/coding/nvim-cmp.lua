return {
    enabled = false,
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            "hrsh7th/cmp-buffer", -- Buffer source for nvim-cmp
            "hrsh7th/cmp-path",   -- Path source for nvim-cmp
            "hrsh7th/cmp-cmdline", -- Command-line source for nvim-cmp
            "L3MON4D3/LuaSnip",   -- Snippet engine
            "saadparwaiz1/cmp_luasnip", -- Snippet source for nvim-cmp
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- Setup nvim-cmp
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- Use LuaSnip as the snippet engine
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })

            -- Use nvim-cmp for command-line completion
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}
