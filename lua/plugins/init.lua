return {
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- Detect tabstop and shiftwidth automatically
  -- luevano: not sure how I feel about this, need to check later
  'tpope/vim-sleuth',
  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- required for nvim-qt on windows
  { 'equalsraf/neovim-gui-shim' },
}
