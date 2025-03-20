-- Environment switcher for Python environments
-- Improved to detect Poetry environments in both terminal Neovim and Neovide

-- Get home directory in a cross-platform way
local home = vim.loop.os_homedir()

-- Check operating system
local is_windows = vim.fn.has('win32') == 1
local is_mac = vim.fn.has('mac') == 1

-- Define Poetry paths based on OS
local poetry_path
if is_windows then
    poetry_path = vim.fn.expand(os.getenv("APPDATA") .. "\\pypoetry\\virtualenvs")
elseif is_mac then
    poetry_path = home .. "/Library/Caches/pypoetry/virtualenvs"
else
    -- Linux default
    poetry_path = home .. "/.cache/pypoetry/virtualenvs"
end

-- Configure Python environment paths to check
local custom_python_envs = {
    { base_path = vim.fn.expand("~/.venvs"), source = "venvs" },
    { base_path = poetry_path, source = "poetry" },
    -- Local project poetry venv (direct path check)
    { base_path = vim.fn.getcwd() .. "/.venv", source = "poetry-local", direct = true },
}

-- Wrapper to get environment from a base path
local get_venvs_wrapper = function(base_path, source, opts)
    local venvs = {}
    if base_path == nil then
        return venvs
    end

    -- Handle direct path case (for .venv in project directory)
    if opts and opts.direct then
        if vim.fn.isdirectory(base_path) == 1 then
            table.insert(venvs, {
                name = "project-venv",
                path = base_path,
                source = source,
            })
        end
        return venvs
    end

    -- Check if the path exists before scanning
    if vim.fn.isdirectory(base_path) == 0 then
        return venvs
    end

    local paths = require("plenary.scandir").scan_dir(
        base_path,
        vim.tbl_extend(
            "force",
            { depth = 1, only_dirs = true, silent = true },
            opts or {}
        )
    )

    for _, path in ipairs(paths) do
        local name = require("plenary.path"):new(path):make_relative(base_path)

        -- Clean up Poetry environment names
        if source == "poetry" then
            -- Extract project name from Poetry's naming format (project-name-hash-py3.x)
            name = string.match(name, "(.+)%-py%d%.%d%-%w+") or name
        end

        table.insert(venvs, {
            name = name,
            path = path,
            source = source,
        })
    end
    return venvs
end

return {
    "AckslD/swenv.nvim",
    keys = {
        { "<space>e", function() require("swenv.api").pick_venv() end, desc = "Swenv: Switch python env" },
    },
    config = function()
        -- If in Neovide, ensure PATH is properly set
        if vim.g.neovide then
            -- Force reload PATH and other environment variables
            -- This can help with environment detection issues
            if not is_windows then
                vim.env.PATH = vim.fn.system("echo $PATH"):gsub("\n", "")
            end
        end
    end,
    opts = {
        get_venvs = function()
            -- Debug - uncomment to troubleshoot
            print("Current directory:", vim.fn.getcwd())

            -- Default paths from environments
            local venvs = require("swenv.api").get_venvs()

            -- Loop through the paths in custom_python_envs and expand
            for _, path in ipairs(custom_python_envs) do
                -- Debug - uncomment to troubleshoot
                print("Checking path:", path["base_path"])
                local envs = get_venvs_wrapper(path["base_path"], path["source"],
                    path.direct and { direct = true } or nil)
                -- Debug - uncomment to troubleshoot
                print("Found environments:", #envs)
                vim.list_extend(venvs, envs)
            end
            return venvs
        end,
        -- Path passed to `get_venvs`
        venvs_path = nil,
        -- Something to do after setting an environment
        post_set_venv = function()
            -- Restart LSP
            -- vim.cmd.LspRestart()

            -- Reset python path in nvim
            local current_env = require("swenv.api").get_current_venv()
            vim.g.python3_host_prog = current_env.path .. "/bin/python"

            -- Restart DAP with new python path
            require("lazy.core.loader").reload("nvim-dap")
            require("lazy.core.loader").reload("nvim-dap-ui")

            vim.notify("Switched env to: " .. current_env.name .. " [" .. current_env.source .. "]")
        end,
    }
}
