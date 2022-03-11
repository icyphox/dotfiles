require 'paq' {
  'savq/paq-nvim';
  'lewis6991/impatient.nvim';
  'tpope/vim-rsi';
  'tpope/vim-surround';
  'wellle/targets.vim';
  'neovim/nvim-lspconfig';
  'airblade/vim-gitgutter';
  'lewis6991/impatient.nvim';
  'nvim-treesitter/nvim-treesitter';
  'nvim-treesitter/playground';
  { 'ms-jpq/coq_nvim', branch='coq' };
  { 'ms-jpq/coq.artifacts', branch='artifacts' };
  { 'vim/better-text-objs', url='https://git.peppe.rs' };
}

-- impatient.nvim
-- TODO: remove this once it's merged
require 'impatient'

require('settings')
require('maps')
require('statusline.line')
require('treesitter')
require('fzy/fzy')

-- lsp setup
require('lsp.config')
require('lsp.python')
require('lsp.go')
