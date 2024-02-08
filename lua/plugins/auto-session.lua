return {
  'rmagatti/auto-session',
  opts = {
    log_level = 'error',
    auto_session_enabled = true,
    auto_session_create_enabled = false,
    auto_save_enabled = false, -- i only want to save some sessions
    auto_restore_enabled = true, -- always restore if session exists
    -- handle closing the neotree window/buffer as it results in errors when loading the session
    pre_save_cmds = {
      function()
        -- dirty way of handling neotree not being loaded yet (lazy load on <leader>nt)
        local _ = pcall(vim.cmd, 'Neotree close')
      end,
    },
  },
  config = function(_, opts)
    local ass = require('auto-session')
    ass.setup(opts)
    local sl = require('auto-session.session-lens')

    vim.keymap.set('n', '<leader>asr', ass.RestoreSession, { desc = '[a]uto [s]ession: [r]estore' })
    vim.keymap.set('n', '<leader>ass', ass.SaveSession, { desc = '[a]uto [s]ession: [s]ave' })
    vim.keymap.set('n', '<leader>asd', ass.DeleteSession, { desc = '[a]uto [s]ession: [d]elete' })
    vim.keymap.set('n', '<leader>asl', sl.search_session, { desc = '[a]uto [s]ession: [l]list' })
  end
}
