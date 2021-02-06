local fn = vim.fn
local cmd = vim.cmd
local M = {}


local function build_index()
  local lines = {}

  -- index each line in the current buffer
  -- for jumping to
  for line = 1, fn.line('$') do
    lines[fn.getline(line)] = line
  end

  local outfile = fn.tempname()
  local f = io.open(outfile, 'a')
  for l, _ in pairs(lines) do
    f:write(l, '\n')
  end
  f:close()

  return outfile, lines
end

function M.fzy_jmp()
  local outfile = fn.tempname()
  local idxfile, lines = build_index()
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
    line_choice, _ = string.gsub(line_choice, '\n', '')

    -- jump to line
    cmd(':' .. lines[line_choice])

    -- housekeeping
    f:close()
    os.remove(outfile)
    os.remove(idxfile)
  end })
end

return M
