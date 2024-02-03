return {
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs      = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = true,  -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      on_attach  = function(bufnr)
        local gs = require('gitsigns')

        -- TODO: use this function for most of the keymaps across plugins?
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>gp', gs.prev_hunk, { desc = '[g]it: [p]revious hunk' })
        map('n', '<leader>gn', gs.next_hunk, { desc = '[g]it: [n]ext hunk' })
        map('n', '<leader>gv', gs.preview_hunk, { desc = '[g]it: [v]iew hunk' })
        map('n', '<leader>gb', gs.toggle_current_line_blame, { desc = '[g]it: [b]lame toggle' })
      end,
    },
  },
}
