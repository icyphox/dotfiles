-- set highlights for statusline sections
vim.api.nvim_exec(
[[
	hi PrimaryBlock ctermfg=06 ctermbg=00
	hi SecondaryBlock   ctermfg=07 ctermbg=00
	hi Blanks   ctermfg=08 ctermbg=00
  hi GitClean ctermfg=02 ctermbg=00
  hi GitDirty ctermfg=01 ctermbg=00
]], false)

local clean = '•'
local dirty = '×'

local function is_clean()
  local handle = io.popen('git status --porcelain 2> /dev/null')
  local status = handle:read('*a')

  if status ~= '' then return false end
  return true
end

local function git_branch()
  local handle = io.popen('git branch --show-current 2> /dev/null')
  local branch = handle:read('*a'):gsub('\n', '')
  local rc = { handle:close() }
  if rc[1] then
    local out = ' ' .. branch
    return out
  else
    return ''
  end
end

local function git_sym()
  if is_clean() then
    return ' %#GitClean#' .. clean
  else
    return ' %#GitDirty#' .. dirty
  end
end

local stl = {
  '%#PrimaryBlock#',
  '%f',
  '%#Blanks#',
  '%m',
  '%#SecondaryBlock#',
  git_branch(),
  git_sym(),
  '%=',
  '%#SecondaryBlock#',
  '%l,%c ',
  '%#PrimaryBlock#',
  '%{&filetype}',
}

vim.opt_global.statusline = table.concat(stl)
