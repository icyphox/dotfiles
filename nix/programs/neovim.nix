{ config
, pkgs
, self
, lib
, ...
}:

let
  tabout = pkgs.vimUtils.buildVimPlugin {
    name = "tabout.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "abecodes";
      repo = "tabout.nvim";
      rev = "be655cc7ce0f5d6d24eeaf8b36e82693fd2facca";
      sha256 = "sha256-wB9HIS0HW1DExgQ/is8/ejpH9FVYfH4UpS9HA6pgYK4=";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    withNodeJs = false;
    vimAlias = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      gotools
      gopls
      go
      nodePackages.vscode-langservers-extracted
      sumneko-lua-language-server
    ];
    extraConfig = ''
      runtime _init.lua
    '';
    plugins = with pkgs.vimPlugins; [
      packer-nvim

      nvim-cmp
      cmp-buffer
      cmp_luasnip
      cmp-nvim-lsp
      cmp-treesitter
      cmp-path


      nvim-lspconfig
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      luasnip
      playground
      vim-surround
      targets-vim
      vim-gitgutter
      vim-rsi
      nvim-treesitter-textobjects
      conflict-marker-vim
      tabout
      vim-jsonnet
      vim-pencil
    ];
  };
}
