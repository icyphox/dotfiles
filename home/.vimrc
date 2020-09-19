" _       _ _         _           
"(_)_ __ (_) |___   _(_)_ __ ___  
"| | '_ \| | __\ \ / / | '_ ` _ \ 
"| | | | | | |_ \ V /| | | | | | |
"|_|_| |_|_|\__(_)_/ |_|_| |_| |_|
"


call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'NerdyPepper/vim-colors-plain', { 'branch': 'duotone' }
Plug 'dbeniamine/vim-mail'
Plug 'tpope/vim-surround'
" plugins for writing {{{
Plug 'reedes/vim-pencil', { 'for': ['text',  'markdown'] }
Plug 'plasticboy/vim-markdown', { 'for': ['text',  'markdown'] }
" }}}
Plug 'ervandew/supertab'
Plug 'Clavelito/indent-awk.vim'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-rsi'
Plug 'zah/nim.vim'
Plug 'easymotion/vim-easymotion'
call plug#end()

" indentation
augroup indents
	autocmd!
	autocmd FileType less,css,html setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType text,markdown setlocal expandtab
augroup END

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

" keybindings
let mapleader=' '
nnoremap <leader><esc> :nohlsearch<cr>
nnoremap <leader>o :only<cr>
nnoremap H H:exec 'norm! '. &scrolloff . 'k'<cr>
nnoremap L L:exec 'norm! '. &scrolloff . 'j'<cr>
nnoremap <C-t> :tabedit
nnoremap <leader>n :bnext<cr>
nnoremap <leader>p :bprev<cr>

" Not an editor command: Wqa
:command! WQ wq
:command! Wq wq
:command! Wqa wqa
:command! W w
:command! Q q

" statusline
let g:currentmode={
			\ 'n'  : 'normal ',
			\ 'no' : 'n·operator pending ',
			\ 'v'  : 'visual ',
			\ 'V'  : 'v·line ',
			\ '' : 'v·block ',
			\ 's'  : 'select ',
			\ 'S'  : 's·line ',
			\ '' : 's·block ',
			\ 'i'  : 'insert ',
			\ 'R'  : 'replace ',
			\ 'Rv' : 'v·replace ',
			\ 'c'  : 'command ',
			\ 'cv' : 'vim ex ',
			\ 'ce' : 'ex ',
			\ 'r'  : 'prompt ',
			\ 'rm' : 'more ',
			\ 'r?' : 'confirm ',
			\ '!'  : 'shell ',
			\ 't'  : 'terminal '}

hi PrimaryBlock   ctermfg=06 ctermbg=00
hi SecondaryBlock ctermfg=08 ctermbg=00
hi Blanks   ctermfg=07 ctermbg=00

set statusline=
set statusline+=%#PrimaryBlock#
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%#SecondaryBlock#
set statusline+=%{StatuslineGit()}
set statusline+=%#Blanks#
set statusline+=\ %f\ 
set statusline+=%m
set statusline+=%=
set statusline+=%#SecondaryBlock#
set statusline+=\ %l\  
set statusline+=%#PrimaryBlock#
set statusline+=%{&filetype}

" for git branch in statusline, from nerdypepper
function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction


" bunch of functions
function! S_gitgutter()  " formatted git hunk summary for statusline
	if exists('b:gitgutter')
		let l:summary = b:gitgutter.summary
		if l:summary[0] != 0 || l:summary[1] != 0 || l:summary[2] != 0
			return ' +'.l:summary[0].' ~'.l:summary[1].' -'.l:summary[2].' '
		endif
	endif
	return ''
endfunction

function! StatuslineGit()
	let l:branchname = GitBranch()
	return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

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

" vim-markdown 
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_yaml_frontmatter=1
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal=0

" vim-pencil
let g:pencil#textwidth = 72
let g:pencil#conceallevel = 0
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,text call pencil#init({'wrap': 'hard', 'autoformat': 0})
augroup END

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

" for the Workman layout

" --- Keyboard  ----------------------------------------------------------------------
function Keyboard(type)
  if a:type == "workman"

  " --- Movement ---
    noremap o l|          " move right
    noremap e k|          " move up
    noremap n j|          " move downn
    noremap y h|          " move left

    noremap <C-f> <C-u>|  " move half page up
    noremap <C-h> <C-d>|  " move half page down
    noremap <C-v> <C-b>|  " move one page up
    noremap <C-t> <C-f>|  " move one page down
    noremap <C-r> <C-e>|  " scroll text up
    noremap <C-j> <C-y>|  " scroll text down

    noremap Y H|          " move to top of screen
    noremap L M|          " move to middle of screen
    noremap O L|          " move to bottom of screen

    noremap d w|          " move to beginning of next word
    noremap D W|          " move to beginning of next word after a whitespace
    noremap v b|          " move to previous beginning of word
    noremap V B|          " move to beginning of previous word before a whitespace
    noremap r e|          " move to end of word
    noremap R E|          " move to end of word before a whitespace
    noremap gr ge|        " move to previous end of word
    noremap gR gE|        " move to previous end of word before a whitespace

            "  zz           scroll the line with the cursor to the center of the screen
    noremap zb zt|        " scroll the line with the cursor to the top
    noremap zv zb|        " scroll the line with the cursor to the bottom

  " --- Insert ---
            " a             append text after the cursor
            " A             append text at the end of the line
    noremap u i|          " insert text before the cursor
    noremap U I|          " insert text before the first non-blank in the line
    noremap p o|          " begin a new line below the cursor and insert text
    noremap P O|          " begin a new line above the cursor and insert text

  " --- Del, Change, Yank, Past, Undo, Redo ---
    noremap h d|          " del text under {motion}
    noremap H D|          " del to end of line
            " x             del character below cursor
            " s             substitute char under cursor
            " s             substitute entire line
    noremap m c|          " change {motion} text (into register) and begin insert
    noremap M C|          " change to end of line
    noremap w r|          " replace current character
    noremap W R|          " replace character until esc

    noremap j y|          " yank
    noremap J Y|          " yank line
    noremap ; p|          " put below current line
    noremap : P|          " put abowe current line

    noremap f u|          " undo
            " ctrl+r        redo

  " --- Search ---
            " *             next whole word under cursor
            " #             previous whole word under cursor
            " g*            next matching search (not whole word) pattern under cursor
            " g#            previous matching search (not whole word) pattern under cursor
    noremap k n|          " next matching search pattern
    noremap K N|          " previous matching search pattern

    noremap t f|          " to next 'X' after cursor, in the same line (X is any character)
    noremap T F|          " to previous 'X' before cursor
    noremap b t|          " til next 'X' (similar to above, but cursor is before X)
    noremap B T|          " till previous 'X'
    noremap i ;|          " repeat above, in same direction
    noremap I :|          " repeat above, in reverse direction

    noremap c v|          " enter visual mode
    noremap <C-c> <C-v>|  " enter visual block mode

    silent! unmap jj
    imap nn <Esc>|        " use 'nn' to exit insert mode

  else " qwerty
    call UnmapWorkman()
  endif
endfunction

function UnmapWorkman()

  " --- Unmap Workman keys ---
  silent! unmap o
  silent! unmap e
  silent! unmap n
  silent! unmap y
  silent! unmap <C-f>
  silent! unmap <C-h>
  silent! unmap <C-v>
  silent! unmap <C-t>
  silent! unmap <C-r>
  silent! unmap <C-j>
  silent! unmap Y
  silent! unmap L
  silent! unmap O
  silent! unmap d
  silent! unmap D
  silent! unmap v
  silent! unmap V
  silent! unmap r
  silent! unmap R
  silent! unmap gr
  silent! unmap gR
  silent! unmap zb
  silent! unmap zv
  silent! unmap u
  silent! unmap U
  silent! unmap p
  silent! unmap P
  silent! unmap h
  silent! unmap H
  silent! unmap m
  silent! unmap M
  silent! unmap w
  silent! unmap W
  silent! unmap j
  silent! unmap J
  silent! unmap ;
  silent! unmap :
  silent! unmap f
  silent! unmap k
  silent! unmap K
  silent! unmap t
  silent! unmap T
  silent! unmap b
  silent! unmap B
  silent! unmap i
  silent! unmap I
  silent! unmap c
  silent! unmap <C-c>

  silent! unmap nn
  imap jj <Esc>|          " use 'jj' to exit insert mode

endfunction


autocmd VimEnter * call Keyboard("workman")| " load workman layout at startup

" quickly change layouts - default <Leader> = \
:noremap <Leader>q :call Keyboard("qwerty")<CR>:echom "qwerty keyboard layout"<CR>
:noremap <Leader>w :call Keyboard("workman")<CR>:echom "workman keyboard layout"<CR>
