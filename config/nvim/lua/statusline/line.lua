local git = require('statusline.git')
local utils = require('utils')

-- set highlights for statusline sections
vim.api.nvim_exec(
[[
  hi PrimaryBlock ctermfg=06 ctermbg=00
  hi SecondaryBlock   ctermfg=07 ctermbg=00
  hi Blanks   ctermfg=08 ctermbg=00
  hi GitClean ctermfg=02 ctermbg=00
  hi GitDirty ctermfg=01 ctermbg=00
]], false)

local git_info
if git.in_git then
  git_info = string.format(' %s %s', git.branch(), git.status())
else
  git_info = ''
end


local stl = {
  '%#PrimaryBlock#',
  '%f',
  '%#Blanks#',
  '%m',
  '%#SecondaryBlock#',
  git_info,
  '%=',
  '%#SecondaryBlock#',
  '%l,%c ',
  '%#PrimaryBlock#',
  '%{&filetype}',
}

_G.statusline = function()
  return table.concat(stl)
end

utils.create_augroup({
  { 'WinEnter,BufEnter', '*', 'setlocal', 'statusline=%!v:lua.statusline()' },
}, 'Statusline')
