-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
local util = require('user.util')
local Popup = require('nui.popup')

local function run_and_exit_on_keypress(command)
  local popup = Popup {
    enter = true,
    relative = "editor",
    position = "50%",
    size = "80%",
    border = {
      style = "rounded",
      text = { top = command },
    }
  }

  popup.keep_alive = false

  popup:mount()
  vim.fn.termopen(command)
  vim.cmd('startinsert')
end

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

    -- move between tabs
    ["<Tab>"] = {
      function()
        require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
      end,
      desc = "Next buffer"
    },

    ["<S-Tab>"] = {
      function()
        require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
      end,
      desc = "Previous buffer",
    },

    -- Compile C++ program
    ["<F8>"] = {
      function()
        if vim.bo.filetype == "cpp" then
          vim.cmd("w")
          run_and_exit_on_keypress("g++ " .. vim.fn.expand("%") .. " -O2 -DBLAT -std=c++20 -Wall -fsanitize=address,undefined,signed-integer-overflow -o " .. vim.fn.expand("%:r"))
        end
      end,
      desc = "Compile C++ Code",
    },

    ["<F9>"] = {
      function()
        if vim.bo.filetype == "cpp" then
          run_and_exit_on_keypress("./" .. vim.fn.expand("%:r"))
        end
      end,
      desc = "Run C++ File"
    },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },

  i = {
    ["<F1>"] = { 'copilot#Accept("<CR>")', silent = true, expr = true, replace_keycodes = false },
    ["<F2>"] = { 'copilot#Next()', silent = true, expr = true, replace_keycodes = false },
    ["<F3>"] = { 'copilot#Previous()', silent = true, expr = true, replace_keycodes = false },
  }
}
