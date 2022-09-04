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
require 'lsp.js'

-- plugins not in nixpkgs

require 'packer'.startup(function(use)
  use {
    'Pocco81/true-zen.nvim',
    ft = {'markdown'},
    config = function()
      require 'true-zen'.setup{
        integrations = {
          tmux = true,
        },
        modes = {
          ataraxis = {
            auto_padding = true,
            custom_bg = {'darken', 0.54},
            quit_untoggles = false
          }
        }
      }
    end
  }

  use 'kana/vim-textobj-user'
  use 'preservim/vim-textobj-quote'
end)
