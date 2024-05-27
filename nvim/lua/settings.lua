local o = vim.opt
local autocmd = vim.api.nvim_create_autocmd
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
o.foldenable = false
o.conceallevel = 2
o.mouse = 'a'
o.wildmenu = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.showmode = true
o.cursorline = false
o.listchars='tab:│ ,nbsp:␣,trail:·,extends:>,precedes:<'
o.hidden = true
o.completeopt = { 'menuone', 'noselect', 'noinsert' }
o.formatoptions:append('c')
o.signcolumn = 'yes:2'
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

cmd('syntax on')
cmd('colorscheme plain')
autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank{timeout=200}
  end,
})

o.background = 'light'
o.termguicolors = false

-- gitgutter options
g.gitgutter_override_sign_column_highlight = 0
g.gitgutter_sign_added                     = '+'
g.gitgutter_sign_modified                  = '±'
g.gitgutter_sign_removed                   = '-'
g.gitgutter_sign_removed_first_line        = '^'
g.gitgutter_sign_modified_removed          = '#'

-- window-local options
o.number = false
o.list = true
o.wrap = false

-- buffer-local options
o.expandtab = true

-- set statusline
stl = require('statusline.line')
o.statusline = '%!luaeval("stl.statusline()")'

-- u.create_augroup({
--     { 'BufRead,BufNewFile', '/tmp/nail-*', 'setlocal', 'ft=mail' },
--     { 'BufRead,BufNewFile', '*s-nail-*', 'setlocal', 'ft=mail' },
-- }, 'ftmail')

-- restore cursor
autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    vim.fn.setpos(".", vim.fn.getpos("'\""))
  end,
})

-- unknown files are 'text'
autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == "" then
      vim.bo.filetype = 'text'
    end
  end,
})

-- keymap files are dts
autocmd({'BufEnter','BufNewFile','BufRead'}, {
  pattern = '*.keymap',
  callback = function()
    vim.bo.filetype = 'dts'
  end
})

-- vim-textobj-quote only in ~/docs/writing
autocmd({'BufEnter','BufNewFile','BufRead'}, {
  pattern = '*.md',
  callback = function()
    local cwd = vim.fn.expand('%:p')
    if cwd:find('/home/icy/docs/writing', 1, true) == 1 then
      vim.fn['textobj#quote#init']()
      vim.fn['pencil#init']({wrap = 'soft'})
      vim.keymap.set('i', '--', '—', {silent = true})
      vim.opt.breakindent = false
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 4
    end
  end
})

-- mdx files are markdown
autocmd({'BufEnter','BufNewFile','BufRead'}, {
  pattern = '*.mdx',
  callback = function()
    vim.bo.filetype = 'markdown'
  end
})

-- filetype.nvim
g.do_filetype_lua = 1
g.did_load_filetypes = 0

-- disable built-in plugins
local disabled_built_ins = {
  'gzip',
  'shada_plugin',
  'tarPlugin',
  'tar',
  'zipPlugin',
  'zip',
}

for i, _ in ipairs(disabled_built_ins) do
  g['loaded_' .. disabled_built_ins[i]] = 1
end

-- tmp
vim.g.gui_font_face = 'Noto Serif'
