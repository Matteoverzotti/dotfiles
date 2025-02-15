-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing
local util = require('util')
local Popup = require('nui.popup')

local function run_and_exit_on_keypress(command)
  local popup = Popup {
    enter = true,
    relative = "editor",
    position = "50%",
    size = "80%",
    wrap = true,
    border = {
      style = "rounded",
      text = { top = command },
    },
    keep_alive = false
  }

  popup:mount()
  vim.fn.termopen(command)
  vim.cmd('startinsert')
end


---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = false,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        clipboard = "unnamed",
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        shiftwidth = 4, -- Number of space inserted for indentation
        showtabline = 4, -- always display tabline
        tabstop = 4, -- Number of space in a tab
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `Tab` and `Shift-Tab`
        ["<Tab>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["<S-Tab>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },

        -- Compile C++ program
        ["<F8>"] = {
          function()
            if vim.bo.filetype == "cpp" then
              vim.cmd("w")
              vim.fn.mkdir(vim.fn.expand("%:p:h") .. "/bin", "p")
              run_and_exit_on_keypress("g++ " .. vim.fn.expand("%:p") ..
                " -O2 -DBLAT -std=c++20 -Wall -fsanitize=address,undefined,signed-integer-overflow -o "
                .. vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
            elseif vim.bo.filetype == "c" then
              vim.cmd("w")
              vim.fn.mkdir(vim.fn.expand("%:p:h") .. "/bin", "p")
              run_and_exit_on_keypress("gcc " .. vim.fn.expand("%:p") ..
                " -O2 -DBLAT -Wall -fsanitize=address,undefined,signed-integer-overflow -o "
                .. vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
            end
          end,
          desc = "Compile C++ Code",
        },

        ["<F9>"] = {
          function()
            if vim.bo.filetype == "cpp" then
              run_and_exit_on_keypress(vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
            elseif vim.bo.filetype == "c" then
              run_and_exit_on_keypress(vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
            elseif vim.bo.filetype == "python" then
              run_and_exit_on_keypress("python3 " .. vim.fn.expand("%:p"))
            end
          end,
          desc = "Run C++ File"
        },

        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
      i = {
        -- setting a mapping to false will disable it
        ["<Tab>"] = false,
        ["<F1>"] = { 'copilot#Accept("<CR>")', silent = true, expr = true, replace_keycodes = false },
        ["<F2>"] = { 'copilot#Next()', silent = true, expr = true, replace_keycodes = false },
        ["<F3>"] = { 'copilot#Previous()', silent = true, expr = true, replace_keycodes = false },
      }
    },
  },
}
