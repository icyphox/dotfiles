local fn = vim.fn
local cmd = vim.cmd
local M = {}

local function normalize_path(path)
  return vim.fn.fnamemodify(vim.fn.expand(path), ':p:~:.')
end

function M.fzy_buffers(exclude)
  local buffers = {}

  -- list of buffers
  local nbuf = fn.range(1, fn.bufnr('$'))

  -- filter out buffers that don't have 'buflisted' set
  for _, n in ipairs(nbuf) do
    if fn.buflisted(n) then
      buffers[fn.bufname(n)] = n
    end
  end

  -- write buffer names to file to feed to fzy
  local buffile = fn.tempname()
  local f = io.open(buffile, "a")
  for b, _ in pairs(buffers) do
    local path = normalize_path(b)
    if not string.match(path, exclude) then
      f:write(path, '\n')
    end
  end
  f:close()

  local fzy_cmd = {
    'fzy -p "buf > " ',
    '< ' .. buffile,
  }

  require('fzy/fzy').fzy_search(table.concat(fzy_cmd), function(stdout)
    -- strip '\n'
    local selected, _ = stdout:gsub('\n', '')
    cmd('bd!')

    cmd('buffer ' .. buffers[ selected ])
    -- housekeeping
    os.remove(buffile)
  end
  )

end

return M
