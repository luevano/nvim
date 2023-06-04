return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    filesystem = {
      follow_current_file = true,
      hijack_netrw_behavior = 'open_current',
    },
  },
  -- lazy load on <leader>nt
  keys = {
    { '<leader>nt', '<CMD>Neotree toggle<CR>', desc = 'Toggle [N]eo[t]ree' },
  },
}
