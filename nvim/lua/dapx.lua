local dap = require 'dap'
local dapui = require 'dapui'

dap.set_log_level('INFO')

dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}",
  },
}

dap.adapters.go = {
  type = "server",
  port = "${port}",
  executable = {
    command = 'dlv',
    args = { "dap", "-l", "127.0.0.1:${port}" },
  },
}

require 'dap-go'.setup {
  dap_configurations = {
    {
      type = "go",
      name = "Debug (main.go)",
      request = "launch",
      program = "${workspaceFolderBasename}/cmd/main.go",
    },
  },
}

dapui.setup {
  controls = {
    element = "repl",
    enabled = true,
    icons = {
      disconnect = "■",
      pause = "",
      play = "▶",
      run_last = "≪",
      step_back = "←",
      step_into = "↓",
      step_out = "↑",
      step_over = "→",
      terminate = "✗"
    }
  },
  expand_lines = false,
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  layouts = {
    {
      elements = {
        "scopes",
        "repl",
      },
      size = 0.3,
      position = "bottom"
    },
    {
      elements = {
        "breakpoints"
      },
      size = 0.1,
      position = "left",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil,
  },
}

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
--dap.listeners.before.event_terminated.dapui_config = function()
--  dapui.close()
--end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

vim.fn.sign_define('DapBreakpoint', {text = '•'})

require 'dapui.config.highlights'.setup()
