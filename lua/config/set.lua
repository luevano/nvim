-- :h vim.<dict> (dict: g, w, b, t, v, etc) for global variable help
-- and :h (vim.<dict>.)<something> for the option help (without the "()" part)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.hlsearch = true

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true

-- Basically a persistent undo file, useful for undotree plugin
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'

-- vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Not sure if these affect some plugins, or if the plugins set their own options
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

vim.o.termguicolors = true

-- Code folding, depends on treesitter
vim.foldmethod='expr'
vim.opt.foldexpr='nvim_treesitter#foldexpr()'
-- Disable folding at startup.
vim.nofoldenable=true

-- 4 spaces for tab indentation
-- not needed, using https://EditorConfig.org instead for 'tpope/vim-sleuth'
-- vim.api.nvim_create_autocmd({'FileType', 'BufEnter', 'BufNewFile', 'BufRead'}, {
--   pattern = { '*.py' },
--   callback = function()
--     vim.cmd[[filetype plugin indent on]]
--     -- show existing tab with 4 spaces width
--     vim.tabstop=4
--     -- when indenting with '>', use 4 spaces width
--     vim.shiftwidth=4
--     -- on pressing tab, insert 4 spaces
--     vim.expandtab=true
--   end
-- })

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
