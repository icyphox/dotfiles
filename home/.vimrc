" _       _ _         _           
"(_)_ __ (_) |___   _(_)_ __ ___  
"| | '_ \| | __\ \ / / | '_ ` _ \ 
"| | | | | | |_ \ V /| | | | | | |
"|_|_| |_|_|\__(_)_/ |_|_| |_| |_|


call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'NerdyPepper/vim-colors-plain', { 'branch': 'duotone' }
Plug 'dbeniamine/vim-mail'
" plugins for writing {{{
Plug 'reedes/vim-pencil', { 'for': ['text',  'markdown'] }
Plug 'plasticboy/vim-markdown', { 'for': ['text',  'markdown'] }
" }}}
Plug 'ervandew/supertab'
Plug 'wellle/targets.vim'
call plug#end()

" indentation
augroup indents
	autocmd!
	autocmd FileType less,css,html setlocal ts=2 sts=2 sw=2 expandtab
	autocmd FileType text,markdown setlocal expandtab
	autocmd FileType rgbds setlocal autoindent
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
set conceallevel=2 
set mouse=a
set wildmenu
set shiftwidth=4     " indent = 4 spaces
set tabstop=4        " tab = 4 spaces
set expandtab
set softtabstop=4    " backspace through spaces
set nocompatible
set noshowmode

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
nnoremap <leader>n :nohlsearch<cr>
nnoremap <leader>o :only<cr>
nnoremap H H:exec 'norm! '. &scrolloff . 'k'<cr>
nnoremap L L:exec 'norm! '. &scrolloff . 'j'<cr>
nnoremap <C-t> :tabedit

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

nmap <silent> H :let g:help_in_tabs = !g:help_in_tabs<CR

" only apply to .txt files
augroup HelpInTabs
	autocmd!
	autocmd BufEnter  *.txt   call HelpInNewTab()
augroup END

" only apply to help files
function! HelpInNewTab ()
	if &buftype == 'help' && g:help_in_tabs
		"Convert the help window to a tab...
		execute "normal \<C-W>T"
	endif
endfunction

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

au BufRead,BufNewFile *.asm set filetype=rgbds

augroup setMail
    autocmd!
    autocmd BufRead,BufNewFile /tmp/nail-* setlocal ft=mail
augroup END

" insert date
abclear
cabbrev dt read !~/bin/date.sh<cr>
cabbrev tm read !date "+\%H:\%M"
