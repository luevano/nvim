-- :h vim.<dict> (dict: g, w, b, t, v, etc) for global variable help
-- and :h (vim.<dict>.)<something> for the option help (without the "()" part)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Prefer Unix line endings, but also recognize DOS (CRLF) when reading
vim.opt.fileformats = { "unix", "dos" }

-- Default to Unix (LF) when creating new files
vim.opt.fileformat = "unix"

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
vim.o.foldenable = false

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Clang
vim.g.c_syntax_for_h = true
