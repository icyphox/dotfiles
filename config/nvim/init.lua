vim.cmd 'packadd paq-nvim'
require 'paq-nvim' {
  'jiangmiao/auto-pairs';
  'airblade/vim-gitgutter';
  { 'vim/vim-colors-plain', url='https://git.peppe.rs' };
  'tpope/vim-surround';
  { 'vim/better-text-objs', url='https://git.peppe.rs' };
  'wellle/targets.vim';
  'tpope/vim-rsi';
  'neovim/nvim-lspconfig';
  { 'ms-jpq/coq_nvim', branch='coq' };
  { 'ms-jpq/coq.artifacts', branch='artifacts' };
}

require('settings')
require('maps')
require('statusline.line')

-- lsp setup
-- require('lsp.yaml') shits too noisy
-- require('lsp.lua') it's horrible
require('lsp.python')
require('lsp.go')
