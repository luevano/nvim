return {
  -- For debugging capabilities, need to change the config
  -- from lspconfig into it's own thing, for more:
  -- https://www.youtube.com/watch?v=mh_EJhH49Ms
  'rust-lang/rust.vim',
  ft = 'rust',
  init = function()
    vim.g.rustfmt_autosave = 1
  end
}
