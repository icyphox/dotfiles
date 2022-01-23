local fn = vim.fn
local cmd = vim.cmd
local M = {}

local function get_line_nr(s)
  for c in s:gmatch('%d+%s') do
    c = string.gsub(c, '%s', '')
    return tonumber(c)
  end
end

local function annotated_input()
  local lines = {}

  -- index each line in the current buffer
  -- for jumping to
  --
  for nr = 1, fn.line('$') do
    table.insert(lines, fn.getline(nr))
  end

  local outfile = fn.tempname()
  local f = io.open(outfile, 'a')
  for n, l in pairs(lines) do
    f:write(n .. '\t' .. l, '\n')
  end
  f:close()

  return outfile, lines
end

function M.fzy_jmp()
  local idxfile, lines = annotated_input()

  fzy_cmd = {
    'fzy -p "jmp > " ',
    '< ' .. idxfile,
  }

  require('fzy/fzy').fzy_search(table.concat(fzy_cmd), function(stdout)
    -- strip '\n'
    local selected, _ = stdout:gsub('\n', '')
    cmd('bd!')

    -- jump to line
    cmd(':' .. get_line_nr(selected))
    -- housekeeping
    os.remove(idxfile)
  end
  )

end
return M
