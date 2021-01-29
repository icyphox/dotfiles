vim.cmd 'packadd paq-nvim'
local paq = require 'paq-nvim'.paq
paq{'savq/paq-nvim', opt=true}

paq 'jiangmiao/auto-pairs'
paq 'airblade/vim-gitgutter'
paq{ 'vim/vim-colors-plain', url='https://git.peppe.rs' }
paq 'dbeniamine/vim-mail'
paq 'tpope/vim-surround'
paq 'plasticboy/vim-markdown'
paq{ 'vim/better-text-objs', url='https://git.peppe.rs' }
paq 'ervandew/supertab'
paq 'wellle/targets.vim'
paq 'tpope/vim-rsi'
paq 'editorconfig/editorconfig-vim'
paq 'zah/nim.vim'

require('settings')
require('maps')
