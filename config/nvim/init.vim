" _       _ _         _           
"(_)_ __ (_) |___   _(_)_ __ ___  
"| | '_ \| | __\ \ / / | '_ ` _ \ 
"| | | | | | |_ \ V /| | | | | | |
"|_|_| |_|_|\__(_)_/ |_|_| |_| |_|


call plug#begin()
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
" plugins for writing {{{
Plug 'reedes/vim-pencil', { 'for': ['text',  'markdown'] }
Plug 'reedes/vim-wordy', { 'for': ['text',  'markdown'] }
Plug 'reedes/vim-litecorrect', { 'for': ['text',  'markdown'] }
Plug 'junegunn/goyo.vim', { 'for': ['text',  'markdown'] }
Plug 'plasticboy/vim-markdown', { 'for': ['text',  'markdown'] }
Plug 'kana/vim-textobj-user', { 'for': ['text', 'markdown'] }
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-textobj-quote' 
" }}}
Plug 'chriskempson/base16-vim'
Plug 'ervandew/supertab'
Plug 'yuttie/comfortable-motion.vim'
Plug 'zchee/deoplete-jedi'
Plug 'zah/nim.vim'
Plug 'wellle/targets.vim'
Plug 'NerdyPepper/agila.vim'
Plug 'w0rp/ale'
" Plug 'skywind3000/vim-keysound'
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
set number
set smartcase
syntax on
filetype plugin indent on
set laststatus=2
set noshowmode
set hlsearch
set incsearch
set ignorecase
set scrolloff=12
set rtp+=~/.fzf
set timeout timeoutlen=3000 ttimeoutlen=100
set undodir=~/.vim/undodir
set nowrap
set cursorline
set conceallevel=2 
set mouse=a
set wildmenu
set shiftwidth=4     " indent = 4 spaces
set noexpandtab      " tabs are tabs
set tabstop=4        " tab = 4 spaces
set softtabstop=4    " backspace through spaces
set nocompatible

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

" deoplete
let g:deoplete#enable_at_startup = 1

" colorscheme
colorscheme agila

" keybindings
let mapleader=' '
nnoremap <leader>n :nohlsearch<cr>
nnoremap <leader>o :only<cr>
nnoremap H H:exec 'norm! '. &scrolloff . 'k'<cr>
nnoremap L L:exec 'norm! '. &scrolloff . 'j'<cr>

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

set statusline=
set statusline+=%#PrimaryBlock#
set statusline+=\ %{g:currentmode[mode()]}
set statusline+=%#TabLineSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#TabLineFill#
set statusline+=\ %f\ 
set statusline+=%m
set statusline+=%=
set statusline+=%#TabLineSel#
set statusline+=\ %l\  
set statusline+=%#PrimaryBlock#
set statusline+=\ %y\ 

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

" deoplete 
let g:help_in_tabs = 1
let g:deoplete#enable_at_startup = 1

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
hi Visual ctermfg=white cterm=bold ctermbg=magenta


" vim-markdown 
let g:vim_markdown_no_default_key_mappings=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_yaml_fromtmatter=1
let g:vim_markdown_folding_disabled=1

" deoplete-jedi
let g:python_host_prog = '/home/icy/.pynvim2/bin/python'
let g:python3_host_prog = '/home/icy/.pynvim3/bin/python'

" keysound
let g:keysound_enable = 1
let g:keysound_volume = 1000
let g:keysound_py_version = 3
let g:keysound_theme = 'default'

" textobj_quote
augroup textobj_quote
  autocmd!
  autocmd FileType markdown call textobj#quote#init({'educate': 1})
  autocmd FileType textile call textobj#quote#init({'educate': 1})
  autocmd FileType text call textobj#quote#init({'educate': 1})
augroup END

" litecorrect
augroup litecorrect
    autocmd!
    autocmd FileType markdown,mkd call litecorrect#init()
    autocmd FileType textile call litecorrect#init()
augroup END
