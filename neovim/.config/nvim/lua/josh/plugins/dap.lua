return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = 'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end

      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    keys = {
      {
        '<F5>',
        '<cmd> DapContinue <CR>',
        desc = 'Debug: Start/Continue',
      },
      {
        '<F10>',
        '<cmd> DapStepOver <CR>',
        desc = 'Debug: Step Over',
      },
      {
        '<F9>',
        '<cmd> DapStepOut <CR>',
        desc = 'Debug: Step Out',
      },
      {
        '<F11>',
        '<cmd> DapStepInto <CR>',
        desc = 'Debug: Step Into',
      },
      {
        '<F11>',
        '<cmd> DapStepInto <CR>',
        desc = 'Debug: Step Into',
      },
      {
        '<leader>db',
        '<cmd> DapToggleBreakpoint <CR>',
        desc = 'Debug: Toggle Breakpoint',
      },
    },
    config = function()
      local dap = require 'dap'

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = '127.0.0.1',
        port = 8123,
        executable = {
          command = 'js-debug-adapter',
        },
      }

      for _, language in ipairs { 'typescript', 'javascript' } do
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
            runtimeExecutable = 'node',
          },
        }
      end
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    ft = 'python',
    dependencies = {
      'mfussenegger/nvim-dap',
      'rcarriga/nvim-dap-ui',
    },
    config = function(_, opts)
      local path = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap-python').setup(path)
    end,
  },
  -- {
  --   'mxsdev/nvim-dap-vscode-js',
  --   dependencies = {
  --     'mfussenegger/nvim-dap',
  --   },
  --   config = function()
  --     require('dap-vscode-js').setup {
  --       debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
  --       debugger_cmd = { 'js-debug-adapter' },
  --       adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
  --     }
  --   end,
  -- },
}
