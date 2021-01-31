local cmd = vim.cmd
local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '


options = { noremap = true }
map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<leader>n', ':bnext<cr>', options)
map('n', '<leader>p', ':bprev<cr>', options)

-- Not an editor command: Wqa
cmd(':command! WQ wq')
cmd(':command! WQ wq')
cmd(':command! Wq wq')
cmd(':command! Wqa wqa')
cmd(':command! W w')
cmd(':command! Q q')

--  fzy mappings
if vim.fn.executable('fzy') then
  _G.fzy = require('fzy').fzy
  map(
    '', 
    '<leader>e', 
    ':call v:lua.fzy("find -L . -type f ! -path \'*.git/*\'", ":e")<cr>',
    { noremap=true, silent=true }
  )
else
        print(' not in PATH!')
end
