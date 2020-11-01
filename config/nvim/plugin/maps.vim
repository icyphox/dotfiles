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

