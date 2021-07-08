local M = {}

local git_branch
local clean = '•'
local dirty = '×'

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
    if branch then git_branch = branch
    else git_branch =  HEAD:sub(1,6) end
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
    -- set to nil when git dir was not found
    git_branch = nil
  end
end

function M.branch()
  if not git_branch or #git_branch == 0 then return '' end
  return git_branch
end

local function is_clean()
  if M.in_git then
    local handle = io.popen('git status --porcelain 2> /dev/null')
    local status = handle:read('*a')

    if status ~= '' then return false end
    return true
  end
  return nil
end

-- clean or dirty
function M.status()
  if M.in_git then
    if is_clean() then
      return '%#GitClean#' .. clean
    else
      return '%#GitDirty#' .. dirty
    end
  end
end

watch_head()

return M
