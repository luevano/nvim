-- Better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Split navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Split: Move left' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Split: Move down' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Split: Move up' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Split: Move right' })
vim.keymap.set('n', '<C-left>', '<CMD>vertical resize -5<CR>', { desc = 'Split: Resize left', noremap = true })
vim.keymap.set('n', '<C-down>', '<CMD>resize +5<CR>', { desc = 'Split: Resize down', noremap = true })
vim.keymap.set('n', '<C-up>', '<CMD>resize -5<CR>', { desc = 'Split: Resize up', noremap = true })
vim.keymap.set('n', '<C-right>', '<CMD>vertical resize +5<CR>', { desc = 'Split: Resize right', noremap = true })
