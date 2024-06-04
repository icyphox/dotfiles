local git = require('statusline.git')
local vd = require('vim.diagnostic')
local M = {}

local function diagnostic_highlight(diagnostics)
  local severity = {
    E = diagnostics[vd.severity.E],
    W = diagnostics[vd.severity.W],
    I = diagnostics[vd.severity.I],
    H = diagnostics[vd.severity.N],
  }
  local highlight = {
    E = '%#LineError#',
    W = '%#LineWarning#',
    I = '%#LineInfo#',
    H = '%#LineHint#',
  }
  local stl = {}
  for k, v in pairs(severity) do
    if v > 0 then
      table.insert(stl, ' '..highlight[k]..k..v)
    end
  end
  return table.concat(stl)
end

function M.statusline()
  local stl = {}
  if vim.bo.filetype ~= 'NvimTree' then
    stl = {''}
  end

  local diagnostics = vd.count(0)

  stl = {
    '%#LinePrimaryBlock#',
    '%f',
    '%#LineBlanks#',
    '%m',
    --'%#LineSecondaryBlock#',
    --' '..git.git_branch,
    '%=',
    diagnostic_highlight(diagnostics)..' ',
    '%#LineBlanks#',
    '%#LineSecondaryBlock#',
    '%l,%c ',
    '%#LinePrimaryBlock#',
    '%{&filetype}',
  }
  return table.concat(stl)
end

return M
