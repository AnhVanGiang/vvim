-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Nvim's core settings without plugins
-- ────────────────────────────────────────────────────────────────────────────────────────────────
require("core")

-- Overwrite some custom paths if needed (already defined in lua/core/settings.lua)
-- vim.g.python3_host_prog = ""
-- vim.opt.spellfile = ""

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Setup plugins with the package-manager lazy.nvim
-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Bootstrap lazy.nvim on 1st install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local plugins_cfg_dir = "plugins"

if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Lazy.nvim Configuration
-- ────────────────────────────────────────────────────────────────────────────────────────────────
require("lazy").setup({
    spec = {
        -- Import your plugin configurations from the plugins directory
        { import = plugins_cfg_dir },
    },
    -- Automatically install plugins and set default colorscheme
    install = {
        colorscheme = { "monokai-pro", "catppuccin-macchiato", "habamax" },
    },
    -- Automatically check for updates
    checker = { enabled = true },

    -- Custom UI settings
    ui = {
        border = "rounded",
    },
})

-- ────────────────────────────────────────────────────────────────────────────────────────────────
-- Set the default colorscheme
-- ────────────────────────────────────────────────────────────────────────────────────────────────
local function set_colorscheme(scheme)
    local ok, _ = pcall(vim.cmd.colorscheme, scheme)
    if not ok then
        vim.notify("Colorscheme '" .. scheme .. "' not found! Falling back to default.", vim.log.levels.WARN)
    end
end

-- Set your preferred colorscheme here
set_colorscheme("monokai-pro") -- Set Monokai Pro as the default
