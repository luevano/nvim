return {
  'navarasu/onedark.nvim',
  name = 'colorscheme',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'onedark'
  end,
}
