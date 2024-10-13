return {
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = true
      vim.g.nord_disable_background = false
      vim.g.nord_cursorline_transparent = false
      vim.g.nord_enable_sidebar_background = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_italic = false
      vim.g.nord_bold = false

      require('nord').set()
      -- vim.cmd.colorscheme = 'nord'
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup({
        extra_groups = {
          -- 'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
        },
      })
      vim.keymap.set('n', '<leader>tT', '<CMD>TransparentToggle<CR>', { desc = '[t]oggle [T]ransparency' })
    end,
  },
}
