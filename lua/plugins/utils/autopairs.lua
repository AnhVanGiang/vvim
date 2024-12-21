return {
    {
        "windwp/nvim-autopairs",
        lazy = false, -- Ensure it loads immediately
        config = function()
            require("nvim-autopairs").setup({
                disable_filetype = { "TelescopePrompt", "vim" },
            })
        end,
    },
}
