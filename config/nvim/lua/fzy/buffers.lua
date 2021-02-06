local fn = vim.fn
local cmd = vim.cmd
local M = {}

function M.fzy_buffers()
  local buffers = {}

  -- list of buffers
  local nbuf = fn.range(1, fn.bufnr('$'))

  winid = fn.win_getid()
  -- filter out buffers that don't have 'buflisted' set
  for _, n in ipairs(nbuf) do
    if fn.buflisted(n) then
      buffers[fn.bufname(n)] = n
    end
  end
  
  -- write buffer names to file to feed to fzy
  buffile = fn.tempname() 
  local f = io.open(buffile, "a")
  for b, _ in pairs(buffers) do
    f:write(b, '\n')
  end
  f:close()

  -- file to store fzy selection
  outfile = fn.tempname()

  shell_cmd = {
    '/bin/sh', 
    '-c',
    'fzy -p "buf > " < ' .. buffile .. ' > ' .. outfile
  }

  -- start a new buffer
  cmd('botright 10 new')
  cmd('startinsert')

  fn.termopen(shell_cmd, { on_exit = function()
    -- delete buffer on exit
    cmd('bd!')
    fn.win_gotoid(winid)

    -- read contents of file
    local f = io.open(outfile, 'r')
    buf_choice = f:read('*all')

    -- strip '\n'
    buf_choice, _ = string.gsub(buf_choice, '\n', '')

    -- housekeeping
    f:close()
    os.remove(outfile)
    os.remove(buffile)

    -- switch to selected buffer
    cmd(':buffer ' .. buffers[buf_choice])
  end })
end

return M
