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
      nodePackages.vscode-langservers-extracted
      sumneko-lua-language-server
    ];
    extraConfig = ''
      runtime _init.lua
    '';
    plugins = with pkgs.vimPlugins; [
      coq_nvim
      nvim-lspconfig
      (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      playground
      vim-surround
      targets-vim
      vim-gitgutter
      vim-rsi
      nvim-treesitter-textobjects
    ];
  };
}
