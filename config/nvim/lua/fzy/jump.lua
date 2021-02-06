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
  local outfile = fn.tempname()
  local idxfile, lines = annotated_input()
  shell_cmd = {
    '/bin/sh',
    '-c',
    'fzy -p "jmp > "  < ' ..  idxfile ..  ' > ' .. outfile
  }

  winid = fn.win_getid()
  -- start a new buffer
  cmd('botright 10 new')
  cmd('startinsert')

  fn.termopen(shell_cmd, { on_exit = function()
    -- delete buffer on exit
    cmd('bd!')
    fn.win_gotoid(winid)

    -- read contents of file
    local f = io.open(outfile, 'r')
    line_choice = f:read('*all')

    -- strip '\n'
    selected, _ = string.gsub(line_choice, '\n', '')

    -- jump to line
    cmd(':' .. get_line_nr(selected))

    -- housekeeping
    f:close()
    os.remove(outfile)
    os.remove(idxfile)
  end })
end

return M
