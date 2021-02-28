u = require('utils')

local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g
local cmd = vim.cmd

-- global options
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
o.laststatus = 2
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 12
o.timeoutlen = 3000
o.ttimeoutlen = 100
o.undodir = '~/.cache/nvim/undodir'
o.cursorline = false
o.foldenable = false
o.conceallevel = 2
o.mouse = 'a'
o.wildmenu = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.showmode = false
o.listchars='tab:│ ,nbsp:␣,trail:·,extends:>,precedes:<'
o.hidden = true
o.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
]]

-- i couldn't figure out how to set the colorscheme in lua
vim.cmd('syntax on')
vim.cmd('colorscheme plain')
o.background = 'dark'

-- gitgutter options
g.gitgutter_override_sign_column_highlight = 0
g.gitgutter_sign_added                     = '+'
g.gitgutter_sign_modified                  = '±'
g.gitgutter_sign_removed                   = '-'
g.gitgutter_sign_removed_first_line        = '^'
g.gitgutter_sign_modified_removed          = '#'

-- speed up python
g.python3_host_prog = '$HOME/.pyenv/versions/3.9.1/bin/python3.9'

-- window-local options
wo.number = false
wo.list = true
wo.wrap = false

-- buffer-local options
bo.expandtab = true

-- augroups don't have an interface yet
u.create_augroup({
    { 'BufRead,BufNewFile', '/tmp/nail-*', 'setlocal', 'ft=mail' },
    { 'BufRead,BufNewFile', '*s-nail-*', 'setlocal', 'ft=mail' },
}, 'ftmail')


u.create_augroup({
    { 'BufReadPost', '*', [[
    if line("'\"") > 1 && line("'\"") <= line("$")
      execute "normal! g`\""
    endif
    ]] }
}, 'restorecursor')

cmd('au BufNewFile,BufRead * if &ft == "" | set ft=text | endif')

-- completion-nvim
cmd('au BufEnter * lua require"completion".on_attach()')
g.completion_chain_complete_list = {
  default = {
    { complete_items = { 'lsp' } },
    { complete_items = { 'buffers' } },
    { mode = { '<c-p>' } },
    { mode = { '<c-n>' } }
  },
}
