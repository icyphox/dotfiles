-- set highlights for statusline sections
vim.api.nvim_exec(
[[
	hi PrimaryBlock ctermfg=06 ctermbg=00
	hi SecondaryBlock   ctermfg=07 ctermbg=00
	hi Blanks   ctermfg=08 ctermbg=00
]], false)

local function git_branch()
  local handle = io.popen('git branch --show-current')
  local branch = handle:read('*a'):gsub('\n', '')
  handle:close()
  return branch
end

local function clean_or_dirty()
  local handle = io.popen('git status --porcelain')
  local status = handle:read('*a')

  if status ~= '' then return '*' end
  return status
end

local stl = {
  '%#PrimaryBlock#',
  '%f',
  '%#Blanks#',
  '%m',
  '%#SecondaryBlock#',
  ' ' .. '(git_branch())' .. clean_or_dirty(),
  '%=',
  '%#SecondaryBlock#',
  '%l,%c ',
  '%#PrimaryBlock#',
  '%{&filetype}',
}

vim.wo.statusline = table.concat(stl)
