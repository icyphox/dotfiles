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

" check if fzy is loaded and in PATH
if executable('fzy') && fzy_loaded
    nnoremap <leader>e :call FzyCommand("find . -type f", ":e")<cr>
    nnoremap <leader>v :call FzyCommand("find . -type f", ":vs")<cr>
    nnoremap <leader>s :call FzyCommand("find . -type f", ":sp")<cr>
endif
