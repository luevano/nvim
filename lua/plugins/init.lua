return {
  -- Detect tabstop and shiftwidth automatically,
  -- uses .editorconfig https://editorconfig.org/
  'tpope/vim-sleuth',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- required for nvim-qt on windows
  { 'equalsraf/neovim-gui-shim' },
}
