augroup NixFmt
    autocmd!
    autocmd BufWritePost *.nix | silent! exec '!nixpkgs-fmt %' | silent! edit
augroup END

setlocal ts=2 sts=2 sw=2 expandtab
