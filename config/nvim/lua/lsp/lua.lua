-- only on macOS
util = require('lspconfig.util')


local root_path = '/Users/icy/Leet/lua-language-server'
local bin_path = root_path .. '/bin/macOS/lua-language-server'

require'lspconfig'.sumneko_lua.setup {
  cmd = { bin_path, "-E", root_path .. '/main.lua' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      }
    },
  },
  on_attach = require('maps').on_attach,
}
