vim.cmd 'packadd paq-nvim'

-- impatient.nvim
-- TODO: remove this once it's merged
require('impatient')

require 'paq-nvim' {
  'tpope/vim-rsi';
  'blackCauldron7/surround.nvim';
  'wellle/targets.vim';
  'neovim/nvim-lspconfig';
  'airblade/vim-gitgutter';
  'nathom/filetype.nvim';
  'lewis6991/impatient.nvim';
  { 'ms-jpq/coq_nvim', branch='coq' };
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
