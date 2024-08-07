require('lspconfig').gopls.setup {
  filetypes = { 'go', 'gomod' },
  gopls = {
    experimentalPostfixCompletions = true,
    analyses = {
      unusedparams = true,
      shadow = true,
    },
    staticcheck = true,
    buildFlags = {"-tags=cgo"},
  },
  on_attach = require('maps').on_attach,
}
