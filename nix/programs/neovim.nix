{ config
, pkgs
, self
, lib
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
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.eslint
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
      vim-jsonnet
      vim-pencil
    ];
  };
}
