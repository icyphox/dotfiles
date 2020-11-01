" _       _ _         _           
"(_)_ __ (_) |___   _(_)_ __ ___  
"| | '_ \| | __\ \ / / | '_ ` _ \ 
"| | | | | | |_ \ V /| | | | | | |
"|_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"


call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'git@fern:vim/vim-colors-plain'
Plug 'dbeniamine/vim-mail', { 'for': ['mail'] }
Plug 'tpope/vim-surround'
" plugins for writing {{{
Plug 'reedes/vim-pencil', { 'for': ['text',  'markdown'] }
Plug 'plasticboy/vim-markdown', { 'for': ['text',  'markdown'] }
" }}}
Plug 'ervandew/supertab'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-rsi'
Plug 'zah/nim.vim', { 'for': ['nim'] }
call plug#end()

augroup restorecursor
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   execute "normal! g`\"" |
				\ endif
augroup END

" basic settings
set swapfile
set dir=/tmp
set nonumber
set smartcase
syntax on
filetype plugin indent on
set laststatus=2
set hlsearch
set incsearch
set ignorecase
set scrolloff=12
set rtp+=~/.fzf
set timeout timeoutlen=3000 ttimeoutlen=100
set undodir=~/.vim/undodir
set nowrap
set nocursorline
set nofoldenable
set conceallevel=2 
set mouse=a
set wildmenu
set shiftwidth=4     " indent = 4 spaces
set tabstop=4        " tab = 4 spaces
set expandtab
set softtabstop=4    " backspace through spaces
set nocompatible
set noshowmode
set clipboard=unnamedplus

" wildcard ignores
set wildignore+=.git,.hg,.svn
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
set wildignore+=*.mp3,*.oga,*.ogg,*.wav,*.flac
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.doc,*.pdf,*.cbr,*.cbz
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
set wildignore+=*.swp,.lock,.DS_Store,._*

" colorscheme
colorscheme plain
set background=dark

" git gutter settings
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                     = '+'
let g:gitgutter_sign_modified                  = '±'
let g:gitgutter_sign_removed                   = '-'
let g:gitgutter_sign_removed_first_line        = '^'
let g:gitgutter_sign_modified_removed          = '#'

" comments are italicized
hi Comment cterm=italic
" color overrides
hi CursorLine ctermbg=none

" vim-pencil
let g:pencil#textwidth = 72
let g:pencil#conceallevel = 0

augroup setMail
    autocmd!
    autocmd BufRead,BufNewFile /tmp/nail-* setlocal ft=mail
augroup END

" insert date
abclear
cabbrev dt read !~/bin/date.sh<cr>
cabbrev tm read !date "+\%H:\%M"

" change cursor
" doesn't actually work :(
if exists('$TMUX')
    let &t_SI .= "\ePtmux;\e\e[6 q\e\\"
    let &t_EI .= "\ePtmux;\e\e[2 q\e\\"
    let &t_SR .= "\ePtmux;\e\e[4 q\e\\"
else
    let &t_SI .= "\e[6 q"
    let &t_EI .= "\e[2 q"
    let &t_SR .= "\e[4 q"
endif
