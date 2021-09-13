local cmd = vim.cmd
local map = vim.api.nvim_set_keymap
local M = {}

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '


local options = { noremap = true, silent = true }
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
  _G.fzy_shell_cmd = require('fzy.shell').fzy_shell_cmd
  map(
    '',
    '<leader>e',
    string.format(
    ':call v:lua.fzy_shell_cmd("find -L . -type f %s", ":e")<cr>',
    fzy_ignore{'*.git/*', '*node_modules*', '*.pyc', '*migrations*'}
    ),
    { noremap=true, silent=true }
  )

  _G.fzy_buffers = require('fzy.buffers').fzy_buffers
  map('',
  '<leader>b',
  ':call v:lua.fzy_buffers()<cr>',
  { noremap=true, silent=true }
  )

  _G.fzy_jmp = require('fzy.jump').fzy_jmp
  map('',
  '<leader>f',
  ':call v:lua.fzy_jmp()<cr>',
  { noremap=true, silent=true}
  )
else
  print('fzy not in PATH!')
end

-- lspconfig
function M.on_attach(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', options)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', options)
end

-- completion-nvim
-- FIXME: rewrite this in Lua
vim.api.nvim_exec([[
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

]], false)


-- walmart autopairs
-- vim.api.nvim_set_keymap('i', '{', '{}<esc>i', options)
-- vim.api.nvim_set_keymap('i', '(', '()<esc>i', options)
-- vim.api.nvim_set_keymap('i', '[', '[]<esc>i', options)
-- vim.api.nvim_set_keymap('i', '\'', '\'\'<esc>i', options)
-- vim.api.nvim_set_keymap('i', '\"', '\"\"<esc>i', options)

return M
