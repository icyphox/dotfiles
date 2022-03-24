{ config
, pkgs
, self
, ...
}:

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
    ];
    extraConfig = ''
      runtime _init.lua
    '';
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      coq_nvim
      playground
      vim-surround
      targets-vim
      vim-gitgutter
      vim-rsi
      vim-go
      vim-jsonnet
    ];
  };
}
