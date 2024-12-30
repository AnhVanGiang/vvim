return {
    "L3MON4D3/LuaSnip",
    version = "v2.*",                          -- Follow latest release
    build = "make install_jsregexp",           -- Optional: Install jsregexp for advanced functionality
    opts = {
        enable_autosnippets = true,            -- Enable auto-snippets
        updateevents = "TextChanged,TextChangedI", -- Update snippets as you type
        history = true,                        -- Enable snippet history
    },
    config = function()
        local luasnip = require("luasnip")

        -- Load snippets from custom directory (optional)
        require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })

        -- Key mappings for navigating snippets
        -- vim.keymap.set({ "i", "s" }, "<Tab>", function()
        --     if luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     else
        --         vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", true)
        --     end
        -- end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", true)
            end
        end, { silent = true })

        -- Add friendly-snippets if you use them
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}
