setlocal noexpandtab
setlocal autoindent
setlocal shiftwidth=4
setlocal smarttab
setlocal formatoptions=croql
setlocal tabstop=4

autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)
