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

local function are_we_in_git()
  local handle = io.popen('git rev-parse --is-inside-work-tree 2> /dev/null')
  local out = handle:read('*a'):gsub('\n', '')
  if out == 'true' then
    in_git = true
  end
end

local function is_clean()
  if in_git then
    local handle = io.popen('git status --porcelain 2> /dev/null')
    local status = handle:read('*a')

    if status ~= '' then return false end
    return true
  end
end

local function git_sym()
  if in_git then
    if is_clean() then
      return ' %#GitClean#' .. clean
    else
      return ' %#GitDirty#' .. dirty
    end
  end
end

local function git_branch()
  if in_git then
    local handle = io.popen('git branch --show-current 2> /dev/null')
    local branch = handle:read('*a'):gsub('\n', '')
    local rc = { handle:close() }
    if rc[1] then
      local out = ' ' .. branch .. git_sym()
      return out
    end
  end
    return ''
end

are_we_in_git()
local stl = {
  '%#PrimaryBlock#',
  '%f',
  '%#Blanks#',
  '%m',
  '%#SecondaryBlock#',
  git_branch(),
  '%=',
  '%#SecondaryBlock#',
  '%l,%c ',
  '%#PrimaryBlock#',
  '%{&filetype}',
}

vim.opt_global.statusline = table.concat(stl)
