local fn = vim.fn
local cmd = vim.cmd
local M = {}

function M.fzy_edit(ls_cmd)
  fzy_cmd = {
    ls_cmd,
    ' | fzy -p "edit > "',
  }

  require('fzy/fzy').fzy_search(table.concat(fzy_cmd), function(stdout)
    -- strip '\n'
    local selected, _ = stdout:gsub('\n', '')
    cmd('bd!')
    cmd('e ' .. selected)
  end
  )
end

return M
