-- Fuzzy text jumping
return {
    "ggandor/leap.nvim",
    enabled=false,
    dependencies = {
        "tpope/vim-repeat",
    },
    config = function()
        require("leap").create_default_mappings()
    end,
}
