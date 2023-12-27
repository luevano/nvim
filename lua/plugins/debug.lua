return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    require('mason-nvim-dap').setup {
      automatic_setup = true,
      handlers = {},
      ensure_installed = {
        'delve',
      },
    }

    local nmap = function(keys, func, desc)
      if desc then
        desc = 'DAP: ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end
    nmap('<F5>', dap.continue)
    nmap('<F1>', dap.step_into)
    nmap('<F2>', dap.step_over)
    nmap('<F3>', dap.step_out)
    nmap('<leader>du', dapui.toggle, 'Toggle [u]i')
    nmap('<leader>db', dap.toggle_breakpoint, 'Toggle [b]reakpoint')

    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('dap-go').setup({})
  end,
}
