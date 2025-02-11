-- Winbar component using lsp
return {
    -- Navic
    {
        "SmiteshP/nvim-navic", -- statusline/winbar component using lsp
        event = "VeryLazy",
        enabled = true,
        dependencies = "neovim/nvim-lspconfig",
        opts = {
            highlight = true,
            separator = " 〉",
            -- VScode-like icons
            icons = {
                File = " ",
                Module = " ",
                Namespace = " ",
                Package = " ",
                Class = " ",
                Method = " ",
                Property = " ",
                Field = " ",
                Constructor = " ",
                Enum = " ",
                Interface = " ",
                Function = " ",
                Variable = " ",
                Constant = " ",
                String = " ",
                Number = " ",
                Boolean = " ",
                Array = " ",
                Object = " ",
                Key = " ",
                Null = " ",
                EnumMember = " ",
                Struct = " ",
                Event = " ",
                Operator = " ",
                TypeParameter = " ",
            }
        },
    },
    -- Winbar setup that uses navic
    {
        "utilyre/barbecue.nvim",
        enabled = true,
        name = "barbecue",
        version = "*",
        event = "VeryLazy",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {
        },
    },
}
