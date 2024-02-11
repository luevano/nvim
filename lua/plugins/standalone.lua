return {
  -- Detect tabstop and shiftwidth automatically,
  -- uses .editorconfig https://editorconfig.org/
  'tpope/vim-sleuth',
  -- required for nvim-qt on windows
  'equalsraf/neovim-gui-shim',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
}
