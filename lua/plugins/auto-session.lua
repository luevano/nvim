local function close_plugins()
  -- dirty way of handling neotree not being loaded yet (lazy load on <leader>nt)
  local _ = pcall(vim.cmd, 'Neotree close')
  -- same thing for trouble
  local _ = pcall(vim.cmd, 'TroubleClose')
end

-- from https://github.com/rmagatti/auto-session/pull/230
local function close_unsupported()
  local tabpages = vim.api.nvim_list_tabpages()
  for _, tabpage in ipairs(tabpages) do
    local windows = vim.api.nvim_tabpage_list_wins(tabpage)
    for _, window in ipairs(windows) do
      local buffer = vim.api.nvim_win_get_buf(window)
      local file_name = vim.api.nvim_buf_get_name(buffer)
      -- local is_readable = vim.fn.exists(file_name)
      local is_readable = vim.fn.filereadable(file_name)
      if not is_readable then
        vim.api.nvim_win_close(window, true)
      end
    end
  end
end

return {
  'rmagatti/auto-session',
  opts = {
    log_level = 'error',
    auto_session_enabled = true,
    auto_session_create_enabled = false,
    auto_save_enabled = false,   -- i only want to save some sessions
    auto_restore_enabled = true, -- always restore if session exists
    -- handle closing the neotree window/buffer as it results in errors when loading the session
    pre_save_cmds = {
      close_plugins,
      close_unsupported,
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
