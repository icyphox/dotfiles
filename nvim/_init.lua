

-- TODO: ref: https://github.com/neovim/neovim/pull/15436
-- require 'impatient'

require 'settings'
require 'completion'
require 'maps'
require 'statusline.line'
require 'treesitter'
require 'tree'
require 'fzy/fzy'

-- lsp setup
require 'lsp.config'
require 'lsp.python'
require 'lsp.go'
require 'lsp.lua'
require 'lsp.json'
require 'lsp.js'
require 'lsp.rust'

-- plugins not in nixpkgs
require 'packer'.startup(function(use)
  use 'preservim/vim-textobj-quote'
end)

require 'dapx'
