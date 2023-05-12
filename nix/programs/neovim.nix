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
      nixpkgs-fmt
      gotools
      gopls
      go
      cargo
      rust-analyzer
      rustc
      nodePackages.vscode-langservers-extracted
      nodePackages.typescript-language-server
      nodePackages.typescript
      nodePackages.eslint
      sumneko-lua-language-server

      tree-sitter-grammars.tree-sitter-bash
      tree-sitter-grammars.tree-sitter-yaml
      tree-sitter-grammars.tree-sitter-go
      tree-sitter-grammars.tree-sitter-make
      tree-sitter-grammars.tree-sitter-markdown
      tree-sitter-grammars.tree-sitter-lua
      tree-sitter-grammars.tree-sitter-html
      tree-sitter-grammars.tree-sitter-vim
      tree-sitter-grammars.tree-sitter-nix

      zf
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
      vim-jsonnet
      vim-pencil
    ];
  };
}
