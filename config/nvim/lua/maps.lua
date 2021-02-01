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

local function fzy_ignore(patterns)
  pattern_cmd = {}
  for _, p in ipairs(patterns) do
    table.insert(pattern_cmd, string.format("! -path '%s'", p))
  end

  return table.concat(pattern_cmd, ' ')
end

--  fzy mappings
if vim.fn.executable('fzy') then
  _G.fzy = require('fzy').fzy
  map(
    '', 
    '<leader>e', 
    -- TODO: Rework this directory ignores into a table
    string.format(
    ':call v:lua.fzy("find -L . -type f %s", ":e")<cr>',
    fzy_ignore({'*.git/*', '*node_modules*'})
    ),
    { noremap=true, silent=true }
  )

  --map('',
  --'<leader>f',
  --'')
else
  print('fzy not in PATH!')
end
