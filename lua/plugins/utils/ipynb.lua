return {
    {
        "meatballs/notebook.nvim",
        enabled = true,
        config = function()
            require("notebook").setup()
        end,
    }
}
