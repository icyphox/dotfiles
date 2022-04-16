local cmd = vim.cmd
local map = vim.keymap.set
local u = require 'utils'
local M = {}

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '


local options = { silent = true }
map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<leader>n', ':bnext<cr>', options)
map('n', '<leader>p', ':bprev<cr>', options)

-- search matches in the middle of the window
map('n', 'n', 'nzzzv', options)
map('n', 'N', 'Nzzzv', options)

-- remain in visual after indenting
map('v', '<', '<gv', options)
map('v', '>', '>gv', options)

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
  _G.fzy_edit = require('fzy.edit').fzy_edit
  map(
    '',
    '<leader>e',
    string.format(
      ':call v:lua.fzy_edit("find -L . -type f %s | cut -c3-")<cr>',
      fzy_ignore{'*.git/*', '*node_modules*', '*.pyc', '*migrations*', '*result*'}
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
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', options)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', options)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', options)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', options)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)

  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', 'ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', options)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', 'ff', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', options)
  end
end

-- vim.api.nvim_exec([[
-- " Use <Tab> and <S-Tab> to navigate through popup menu
-- inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
-- inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
-- 
-- ]], false)

-- abbreviations
local star = '★'
local stars = {}
for n = 1, 5
do
  table.insert(stars, star)
  u.iabbrev(n .. '*', table.concat(stars))
end

return M
