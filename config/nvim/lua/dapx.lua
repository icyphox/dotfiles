local dap = require 'dap'

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

require 'dapui'.setup({
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
      },
      size = 0.2,
      position = "left"
    },
    {
      elements = {
        "repl",
        "breakpoints"
      },
      size = 0.3,
      position = "bottom",
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
})

vim.fn.sign_define('DapBreakpoint', {text = '•'})

require 'dapui.config.highlights'.setup()
