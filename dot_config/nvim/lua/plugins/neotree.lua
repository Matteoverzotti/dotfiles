return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            local git_available = vim.fn.executable("git") == 1

            vim.keymap.set("n", "<Leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle Explorer" })

            vim.api.nvim_create_autocmd("BufEnter", {
                desc = "Open Neo-Tree on startup with directory",
                callback = function(args)
                    if package.loaded["neo-tree"] then
                        return
                    end
                    local stats = vim.uv.fs_stat(vim.api.nvim_buf_get_name(args.buf))
                    if stats and stats.type == "directory" then
                        require("lazy").load({ plugins = { "neo-tree.nvim" } })
                        pcall(vim.api.nvim_exec_autocmds, "BufEnter", {
                            group = "NeoTree_NetrwDeferred",
                            buffer = args.buf,
                        })
                    end
                end,
            })

        end
    },
    {
        "antosha417/nvim-lsp-file-operations",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
        },
        config = function()
            require("lsp-file-operations").setup()
        end,
    },
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        config = function()
            require("window-picker").setup({
                filter_rules = {
                    include_current_win = false,
                    autoselect_one = true,
                    -- filter using buffer options
                    bo = {
                        -- if the file type is one of following, the window will be ignored
                        filetype = { "neo-tree", "neo-tree-popup", "notify" },
                        -- if the buffer type is one of following, the window will be ignored
                        buftype = { "terminal", "quickfix" },
                    },
                },
            })
        end,
    },
}
