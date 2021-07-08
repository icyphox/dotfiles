local git = require('statusline.git')
local utils = require('utils')
local M = {}

-- set highlights for statusline sections
vim.api.nvim_exec(
[[
  hi PrimaryBlock ctermfg=06 ctermbg=00
  hi SecondaryBlock   ctermfg=07 ctermbg=00
  hi Blanks   ctermfg=08 ctermbg=00
  hi GitClean ctermfg=02 ctermbg=00
  hi GitDirty ctermfg=01 ctermbg=00
]], false)

function M.statusline()
  local stl = {
    '%#PrimaryBlock#',
    '%f',
    '%#Blanks#',
    '%m',
    '%#SecondaryBlock#',
    ' '..git.git_branch,
    '%=',
    '%#SecondaryBlock#',
    '%l,%c ',
    '%#PrimaryBlock#',
    '%{&filetype}',
  }
  return table.concat(stl)
end

return M
