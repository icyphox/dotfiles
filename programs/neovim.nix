{ config
, pkgs
, self
, lib
, ...
}:

{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    vimAlias = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      nixpkgs-fmt
      gotools
      gopls
      go
      sumneko-lua-language-server
      pyright

      tree-sitter-grammars.tree-sitter-bash
      tree-sitter-grammars.tree-sitter-yaml
      tree-sitter-grammars.tree-sitter-go
      tree-sitter-grammars.tree-sitter-make
      tree-sitter-grammars.tree-sitter-markdown
      tree-sitter-grammars.tree-sitter-lua
      tree-sitter-grammars.tree-sitter-html
      tree-sitter-grammars.tree-sitter-vim
      tree-sitter-grammars.tree-sitter-nix
      tree-sitter-grammars.tree-sitter-python

      zf
      delve
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
      luasnip
      playground
      vim-surround
      targets-vim
      vim-gitgutter
      vim-rsi
      nvim-treesitter-textobjects
      conflict-marker-vim
      vim-pencil
      nvim-tree-lua

      nvim-dap
      nvim-dap-ui
      nvim-dap-go
      vim-textobj-user
    ];
  };
}
