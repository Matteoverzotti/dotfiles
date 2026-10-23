require('core.popup')

-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local opts = { noremap = true, silent = true }

-- delete single character without copying into register
vim.keymap.set('n', 'x', '"_x', opts)

-- Vertical scroll and center
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts)
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts)

-- Find and center
vim.keymap.set('n', 'n', 'nzzzv', opts)
vim.keymap.set('n', 'N', 'Nzzzv', opts)

-- Resize with arrows
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts)

-- Buffers
vim.keymap.set('n', '<Tab>', ':bnext<CR>', opts)
vim.keymap.set('n', '<S-Tab>', ':bprevious<CR>', opts)
vim.keymap.set('n', '<leader>c', ':bdelete!<CR>', opts) -- Close buffer
vim.keymap.set('n', '<leader>b', '<cmd> enew <CR>', opts) -- New buffer

-- Window management
vim.keymap.set('n', '<leader>v', '<C-w>v', opts)  -- split window vertically
vim.keymap.set('n', '<leader>h', '<C-w>s', opts)  -- split window horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts) -- make split windows equal in width & height
vim.keymap.set('n', '<leader>xs', ':close<CR>', opts) -- close current split window

-- Navigate between splits
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

-- Tabs
vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts) -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts) --  go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts) --  go to previous tab

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Stay in indent mode. Remap > and < with Tab and Shift-Tab
vim.keymap.set('v', '<S-Tab>', '<gv', opts)
vim.keymap.set('v', '<Tab>', '>gv', opts)

-- Keep last yanked when pasting
vim.keymap.set('v', 'p', '"_dP', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>/', 'gcc', { remap = true, desc = 'Toggle comment on line' })
vim.keymap.set('x', '<leader>/', 'gc', { remap = true, desc = 'Toggle comment on selection' })

-- Compiling programs
vim.keymap.set('n', '<F8>', function()
  if vim.bo.filetype == "cpp" then
    vim.cmd("w")
    vim.fn.mkdir(vim.fn.expand("%:p:h") .. "/bin", "p")
    run_and_exit_on_keypress("clang++ " .. vim.fn.expand("%:p") ..
      " -O2 -DBLAT -std=c++20 -Wall -fsanitize=address,undefined,signed-integer-overflow -o "
      .. vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
  elseif vim.bo.filetype == "c" then
    vim.cmd("w")
    vim.fn.mkdir(vim.fn.expand("%:p:h") .. "/bin", "p")
    run_and_exit_on_keypress("gcc " .. vim.fn.expand("%:p") ..
      " -O2 -DBLAT -Wall -fsanitize=address,undefined,signed-integer-overflow -o "
      .. vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
  end
end, { desc = 'Compile Code' })


vim.keymap.set('n', '<F9>', function ()
  if vim.bo.filetype == "cpp" then
    run_and_exit_on_keypress(vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
  elseif vim.bo.filetype == "c" then
    run_and_exit_on_keypress(vim.fn.expand("%:p:h") .. "/bin/" .. vim.fn.expand("%:t:r"))
  elseif vim.bo.filetype == "python" then
    run_and_exit_on_keypress("python3 " .. vim.fn.expand("%:p"))
  end
end, { desc = 'Run Code' })

