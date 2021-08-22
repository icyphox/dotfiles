vim.cmd 'packadd paq-nvim'
require 'paq-nvim' {
  'tpope/vim-rsi';
  'tpope/vim-surround';
  'wellle/targets.vim';
  'neovim/nvim-lspconfig';
  'airblade/vim-gitgutter';
  { 'ms-jpq/coq_nvim', branch='coq' };
  { 'ms-jpq/coq.artifacts', branch='artifacts' };
  { 'vim/better-text-objs', url='https://git.peppe.rs' };
  { 'vim/vim-colors-plain', url='https://git.peppe.rs' };
}

require('settings')
require('maps')
require('statusline.line')

-- lsp setup
-- require('lsp.yaml') shits too noisy
-- require('lsp.lua') it's horrible
require('lsp.python')
require('lsp.go')
