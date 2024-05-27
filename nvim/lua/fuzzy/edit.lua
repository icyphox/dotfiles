local fn = vim.fn
local cmd = vim.cmd
local M = {}

function M.fuzzy_edit(fuzzy_cmd)
  fuzzy_cmd = {
    ls_cmd,
    '| zf',
  }

  require('fuzzy/fuzzy').fuzzy_search(table.concat(fuzzy_cmd), function(stdout)
    -- strip '\n'
    local selected, _ = stdout:gsub('\n', '')
    cmd('bd!')
    cmd('e ' .. selected)
  end
  )
end

return M
