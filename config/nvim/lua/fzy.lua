-- returns the fzy output, do with it what you will
local fn = vim.fn
local cmd = vim.cmd
local M = {}

function M.fzy(fzy_cmd, action)
  -- save shell output to a temp file
  file = fn.tempname()
  shell_cmd = {
    '/bin/sh',
    '-c',
    fzy_cmd .. ' | fzy > ' .. file
  }

  -- get current winid to jump back to
  winid = fn.win_getid()

  -- start a new buffer
  cmd('botright 10 new')
  cmd('startinsert')

  -- open a term with the fzy command,
  -- and run callback on exit
  fn.termopen(shell_cmd, { on_exit = function()
    -- delete buffer on exit
    cmd('bd!')
    fn.win_gotoid(winid)

    -- read contents of file
    local f = io.open(file, 'r')
    fzy_out = f:read('*all')

    -- housekeeping
    f:close()
    os.remove(file)

    -- run action against output
    -- ex: ':e somefile'
    vim.cmd(table.concat({ action, fzy_out }, ' '))
  end })

  return fzy_out
end

return M
