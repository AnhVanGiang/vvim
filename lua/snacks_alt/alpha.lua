-- Start page greeter
return {
    "goolord/alpha-nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        local dashboard = require("alpha.themes.dashboard")

        -- Get version
        local function get_version()
            local version = vim.version()
            local nvim_version_info = "NVIM v" ..
                version.major .. "." .. version.minor .. "." .. version.patch
            return nvim_version_info
        end

        -- Set header
        dashboard.section.header.val = {
            "   ██╗  ██╗███╗   ██╗██╗   ██╗██╗███╗   ███╗  ",
            "   ██║ ██╔╝████╗  ██║██║   ██║██║████╗ ████║  ",
            "   █████╔╝ ██╔██╗ ██║██║   ██║██║██╔████╔██║  ",
            "   ██╔═██╗ ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
            "   ██║  ██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
            "   ╚═╝  ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
        }

        -- Set menu
        local update_all = function()
            vim.cmd [[Lazy sync]]
            vim.cmd [[TSUpdateSync]]
            vim.cmd [[MasonUpdate]]
        end
        local cfg_pth = vim.fn.stdpath("config")
        dashboard.section.buttons.val = {
            dashboard.button("e", "󰝒  Edit a new file", ":ene<CR>"),
            dashboard.button("o", "  Old files", ":Telescope oldfiles<CR>"),
            dashboard.button("s", "󰺄  Session manager", ":SessionManager<CR>"),
            dashboard.button("r", "  Remote manager", ":RemoteStart<CR>"),
            dashboard.button("f", "󰱼  File finder", ":Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>"),
            dashboard.button("t", "󱎸  Text finder", ":Telescope live_grep<CR>"),
            dashboard.button("u", "󰏖  Update plugins", update_all),
            dashboard.button("l", "  Language servers", ":Mason<CR>"),
            dashboard.button("h", "󰓙  Health checker", ":checkhealth<CR>"),
            dashboard.button("c", "  Configurations", ":cd " .. cfg_pth .. " | e $MYVIMRC<CR>"),
            dashboard.button("p", "  Pull knvim's configs",
                ":!git --git-dir=" .. cfg_pth .. "/.git --work-tree=" .. cfg_pth .. " pull<CR>"),
            dashboard.button("?", "  Cheatsheet",
                ":e " .. cfg_pth .. "/cheatsheet.md | Outline!<CR>"),
            dashboard.button("q", "󰍃  Quit", ":qa<CR>"),
        }

        -- Set footer
        local fortune = require("alpha.fortune")
        dashboard.section.footer.val = fortune()

        -- Dynamic header padding (center of the page)
        local min_padding = 2
        -- local margin_top_percent = 0.2
        -- local header_padding = vim.fn.max({ min_padding, vim.fn.floor(vim.fn.winheight(0) * margin_top_percent) })
        local page_len = #dashboard.section.header.val + 1 + min_padding +
            2 * #dashboard.section.buttons.val + #dashboard.section.footer.val
        local header_padding = vim.fn.max({ min_padding, vim.fn.floor((vim.fn.winheight(0) - page_len) /
            2) })

        -- Set layout
        dashboard.config.layout = {
            { type = "padding", val = header_padding },
            dashboard.section.header,
            { type = "text",    val = get_version(), opts = { position = "center", hl = "hl_group" } },
            { type = "padding", val = min_padding },
            dashboard.section.buttons,
            dashboard.section.footer,
        }

        -- Send config to alpha
        require("alpha").setup(dashboard.opts)
    end,
}
