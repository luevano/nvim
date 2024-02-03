return {
  'olexsmir/gopher.nvim',
  enabled = true,
  ft = "go",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    -- DAP capabilities
    'mfussenegger/nvim-dap',
  },
  config = function(_, opts)
    -- Some dependencies need to be installed with GoInstallDeps:
    -- gomodifytags
    -- impl
    -- gotests
    -- iferr
    -- I just installed them with mason, it would be easier to install
    -- them here with mason, but my config is already a mess

    require('gopher').setup(opts)
    require('gopher.dap').setup()

    local nmap = function(keys, func, desc)
      if desc then
        desc = 'GO: ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    nmap('<leader>gsa', ':GoTagAdd<Space>', '[s]truct tag [a]dd')
    nmap('<leader>gsr', ':GoTagRm<Space>', '[s]truct tag [r]m')
    nmap('<leader>gii', ':GoImpl<Space>', '[i]mplement [i]nterface')
    nmap('<leader>gie', '<CMD>GoIfErr<CR>', 'generate [i]f [e]rr')
    nmap('<leader>gta', ':GoTestAdd<Space>', '[t]est [a]dd')
    nmap('<leader>gts', '<CMD>GoTestsAll<CR>', '[t]est[s] add all')
    nmap('<leader>gte', '<CMD>GoTestsExp<CR>', '[t]ests add [e]xported')
  end,
}
