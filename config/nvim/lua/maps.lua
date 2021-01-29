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

-- check if fzy is loaded and in PATH
if vim.fn.executable('fzy') then
	map('', '<leader>e', ':call FzyCommand("find . -type f ! -path \'*.git/*\'", ":e")<cr>', { noremap=true, silent=true })
else
        print('fzy not in PATH!')
end
