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
set statusline+=%#Blanks#
set statusline+=\ %f\ 
set statusline+=%m
set statusline+=%=
set statusline+=%#SecondaryBlock#
set statusline+=\ %l,%c\  
set statusline+=%#PrimaryBlock#
set statusline+=%{&filetype}
