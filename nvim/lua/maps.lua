local cmd = vim.cmd
local map = vim.keymap.set
local dap = require 'dap'
local treeapi = require 'nvim-tree.api'
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
  local pattern_cmd = {}
  for _, p in ipairs(patterns) do
    table.insert(pattern_cmd, string.format("-E '%s'", p))
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
      ':call v:lua.fzy_edit("fd -t f -t l")<cr>',
      fzy_ignore{
        '*.git/*',
        '*node_modules*',
        '*.pyc',
        '*migrations*',
        '*result*',
        '*.direnv/*',
      }
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
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', options)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', options)
  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', options)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', options)
  buf_set_keymap('n', 'L', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', options)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', options)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', options)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', options)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', options)
  map('n', 'ff', function()
    vim.lsp.buf.format { async = true }
  end)
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


-- dap
-- Start debugging session
map("n", "<leader>ds", function()
  dap.continue()
  require 'dapui'.open()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
end)

-- Set breakpoints, get variable values, step into/out of functions, etc.
map("n", "<leader>dl", require("dap.ui.widgets").hover)
map("n", "<leader>dc", dap.continue)
map("n", "<leader>db", dap.toggle_breakpoint)
map("n", "<leader>dn", dap.step_over)
map("n", "<leader>di", dap.step_into)
map("n", "<leader>do", dap.step_out)
map("n", "<leader>dC", dap.clear_breakpoints)

-- Close debugger and clear breakpoints
map("n", "<leader>de", function()
  dap.clear_breakpoints()
  require 'dapui'.close()
  dap.terminate()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
end)


local function toggle_tree()
  treeapi.tree.toggle({ find_file = true })
end

-- nvim-tree
map('n', '<leader>tt', toggle_tree)
map('n', '<leader>tf', treeapi.tree.focus)

return M
