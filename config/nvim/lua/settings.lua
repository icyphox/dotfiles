local u = require('utils')

local o = vim.opt
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
o.showmode = true
o.listchars='tab:│ ,nbsp:␣,trail:·,extends:>,precedes:<'
o.hidden = true
o.completeopt = { 'menuone', 'noselect', 'noinsert' }
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

vim.cmd("syntax on")
-- i couldn't figure out how to set the colorscheme in lua
vim.cmd('colorscheme plain')

vim.cmd('au TextYankPost * lua vim.highlight.on_yank{timeout=200}')
o.background = 'light'

-- gitgutter options
g.gitgutter_override_sign_column_highlight = 0
g.gitgutter_sign_added                     = '+'
g.gitgutter_sign_modified                  = '±'
g.gitgutter_sign_removed                   = '-'
g.gitgutter_sign_removed_first_line        = '^'
g.gitgutter_sign_modified_removed          = '#'

-- use a python3 venv
g.python3_host_prog = vim.env.HOME .. '/leet/vim-python3/bin/python3'

-- window-local options
o.number = false
o.list = true
o.wrap = false

-- buffer-local options
o.expandtab = true

-- set statusline
stl = require('statusline.line')
o.statusline = '%!luaeval("stl.statusline()")'

-- augroups don't have an interface yet
u.create_augroup({
    { 'BufRead,BufNewFile', '/tmp/nail-*', 'setlocal', 'ft=mail' },
    { 'BufRead,BufNewFile', '*s-nail-*', 'setlocal', 'ft=mail' },
}, 'ftmail')

-- restore cursor
cmd([[ au BufReadPost * call setpos(".", getpos("'\"")) ]])

-- unknown files are 'text'
cmd('au BufNewFile,BufRead * if &ft == "" | set ft=text | endif')

-- coq.nvim
g.coq_settings = {
  auto_start = 'shut-up',
  display = {
    icons = {
      mode = 'none'
    },
    preview = {
      border = 'solid',
    },
  },
}

-- filetype.nvim
g.did_load_filetypes = 1

-- disable built-in plugins
local disabled_built_ins = {
  'gzip',
  'man',
  'shada_plugin',
  'tarPlugin',
  'tar',
  'zipPlugin',
  'zip',
  'netrwPlugin',
}

for i = 1, 8 do
  g['loaded_' .. disabled_built_ins[i]] = 1
end
