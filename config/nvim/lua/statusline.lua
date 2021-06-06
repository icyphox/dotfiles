-- set highlights for statusline sections
vim.api.nvim_exec(
[[
	hi PrimaryBlock ctermfg=06 ctermbg=00
	hi SecondaryBlock   ctermfg=07 ctermbg=00
	hi Blanks   ctermfg=08 ctermbg=00
]], false)

local function clean_or_dirty()
  local handle = io.popen('git status --porcelain 2> /dev/null')
  local status = handle:read('*a')

  if status ~= '' then return '*' end
  return status
end

local function git_branch()
  local handle = io.popen('git branch --show-current 2> /dev/null')
  local branch = handle:read('*a'):gsub('\n', '')
  local rc = { handle:close() }
  if rc[1] then
    local out = ' ' .. branch .. clean_or_dirty()
    return out
  else
    return ''
  end
end

local stl = {
  '%#PrimaryBlock#',
  '%f',
  '%#Blanks#',
  '%m',
  '%#SecondaryBlock#',
  '%=',
  '%#SecondaryBlock#',
  '%l,%c ',
  '%#PrimaryBlock#',
  '%{&filetype}',
}

vim.opt_global.statusline = table.concat(stl)
