return {
  'tummetott/reticle.nvim',
  event = 'VeryLazy',
  config = function()
    local reticle = require('reticle')
    reticle.setup()

    vim.keymap.set('n', '<leader>tcl', reticle.toggle_cursorline, { desc = '[t]oggle [c]ursor [l]ine' })
    vim.keymap.set('n', '<leader>tcc', reticle.toggle_cursorcolumn, { desc = '[t]oggle [c]ursor [c]olumn' })
    vim.keymap.set('n', '<leader>tcx', reticle.toggle_cursorcross, { desc = '[t]oggle [c]ursor [x]cross' })
  end,
}
