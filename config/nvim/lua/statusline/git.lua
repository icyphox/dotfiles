local M = {}

local sep = package.config:sub(1,1)

local function find_git_dir()
  local file_dir = vim.fn.expand('%:p:h') .. ';'
  local git_dir = vim.fn.finddir('.git', file_dir)
  if #git_dir > 0 then
    M.in_git = true
  end
  return git_dir
end

local function get_git_head(head_file)
  local f_head = io.open(head_file)
  if f_head then
    local HEAD = f_head:read()
    f_head:close()
    local branch = HEAD:match('ref: refs/heads/(.+)$')
    if branch then M.git_branch = branch
    else M.git_branch =  HEAD:sub(1,7) end
  end
  return nil
end

-- event watcher to watch head file
local file_changed = vim.loop.new_fs_event()
local function watch_head()
  file_changed:stop()
  local git_dir = find_git_dir()
  if #git_dir > 0 then
    local head_file = git_dir..sep..'HEAD'
    get_git_head(head_file)
    file_changed:start(head_file, {}, vim.schedule_wrap(function()
      -- reset file-watch
      watch_head()
    end))
  else
    M.git_branch = ''
  end
end

watch_head()

return M
