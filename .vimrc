"          _                    
"   _   __(_)___ ___  __________
"  | | / / / __ `__ \/ ___/ ___/
" _| |/ / / / / / / / /  / /__  
"(_)___/_/_/ /_/ /_/_/   \___/  
"

autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab

set shiftwidth=4     " indent = 4 spaces
set noexpandtab      " tabs are tabs
set tabstop=4        " tab = 4 spaces
set softtabstop=4    " backspace through spaces

execute pathogen#infect()
set swapfile
set dir=/tmp
set number
set smartcase
syntax on
filetype plugin indent on
set laststatus=2
set noshowmode
set hlsearch
set incsearch
"set cursorline
set ignorecase
set scrolloff=12
set rtp+=~/.fzf
set timeout timeoutlen=3000 ttimeoutlen=100
set undodir=~/.vim/undodir

colorscheme agila

let mapleader=' '
nnoremap <leader>n : nohlsearch<cr>
nnoremap <leader>l : Lines<cr>
nnoremap <leader>b : Buffers<cr>
nnoremap <leader>o : only<cr>
nnoremap <leader>t : call GetTabber()<cr>

let g:currentmode={
    \ 'n'  : 'NORMAL ',
    \ 'no' : 'N·Operator Pending ',
    \ 'v'  : 'VISUAL ',
    \ 'V'  : 'V·Line ',
    \ '' : 'V·Block',
    \ 's'  : 'Select ',
    \ 'S'  : 'S·Line ',
    \ '' : 'S·Block',
    \ 'i'  : 'INSERT ',
    \ 'R'  : 'REPLACE ',
    \ 'Rv' : 'V·Replace ',
    \ 'c'  : 'Command ',
    \ 'cv' : 'Vim Ex ',
    \ 'ce' : 'Ex ',
    \ 'r'  : 'Prompt ',
    \ 'rm' : 'MORE ',
    \ 'r?' : 'CONFIRM ',
    \ '!'  : 'SHELL ',
    \ 't'  : 'TERMINAL '}

set statusline=
set statusline+=%#TabLineSel#
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%#TODO#
set statusline+=%{StatuslineGit()}
set statusline+=%#TabLineFill#
set statusline+=\ %f\ 
set statusline+=%m
set statusline+=%#TabLineFill#
set statusline+=%=
set statusline+=%#TODO#
set statusline+=\ %l\  
set statusline+=%#TabLineSel#
set statusline+=\ %y\ 
set statusline+=%#TabLine#

" for git branch in statusline, from nerdypepper
function! GitBranch()
	return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction


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


function! GetTabber()  " a lil function that integrates well with Tabular.vim
	let c = nr2char(getchar())
	:execute 'Tabularize /' . c
endfunction"

" git gutter settings
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                     = '+'
let g:gitgutter_sign_modified                  = '±'
let g:gitgutter_sign_removed                   = '-'
let g:gitgutter_sign_removed_first_line        = '^'
let g:gitgutter_sign_modified_removed          = '#'
highlight clear SignColumn

highlight GitGutterAdd ctermfg=red
highlight GitGutterChange ctermfg=red
highlight GitGutterDelete ctermfg=red
highlight GitGutterChangeDelete ctermfg=red

let g:help_in_tabs = 1

nmap <silent> H :let g:help_in_tabs = !g:help_in_tabs<CR

"Only apply to .txt files...
augroup HelpInTabs
    autocmd!
    autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

"Only apply to help files...
function! HelpInNewTab ()
    if &buftype == 'help' && g:help_in_tabs
        "Convert the help window to a tab...
        execute "normal \<C-W>T"
    endif
endfunction

highlight LineNr ctermbg=none
hi TabLine ctermbg=black
hi TabLineFill ctermbg=black
hi TabLineSel ctermbg=magenta
