-- loaded by home-manager; see: nix/programs/neovim.nix

-- TODO: ref: https://github.com/neovim/neovim/pull/15436
-- require 'impatient'

require 'settings'
require 'completion'
require 'maps'
require 'statusline.line'
require 'treesitter'
require 'fzy/fzy'

-- lsp setup
require 'lsp.config'
require 'lsp.python'
require 'lsp.go'
require 'lsp.lua'
require 'lsp.json'

