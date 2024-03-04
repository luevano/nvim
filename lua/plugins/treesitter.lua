return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = ':TSUpdate',
  -- This needs to be manually pased into config and used in the function(_, opts)
  -- as it has to be configured with the required...'.config'
  opts = {
    ensure_installed = {
      'c',
      'cpp',
      'bash',
      'ini',
      'go',
      'lua',
      'python',
      'typescript',
      'vimdoc',
      'vim',
      'css',
      'html',
      'markdown',
      'markdown_inline',
      'php',
      'sql',
      'gdscript',
      'godot_resource',
      'rust',
    },
    auto_install = false,
    highlight = { enable = true },
    indent = {
      enable = true,
      disable = {
        'python',
        'css', },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<cr>',
        node_incremental = '<tab>',
        node_decremental = '<s-tab>',
        scope_incremental = '<cr>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        include_surrounding_whitespace = false,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- The descriptions are simplistic to match the native descriptions
          ['aa'] = { query = '@parameter.outer', desc = 'a parameter' },
          ['ia'] = { query = '@parameter.inner', desc = 'a parameter' },
          ['af'] = { query = '@function.outer', desc = 'a function' },
          ['if'] = { query = '@function.inner', desc = 'a function' },
          ['ac'] = { query = '@class.outer', desc = 'a class' },
          ['ic'] = { query = '@class.inner', desc = 'a class' },
        },
      },
      -- TODO: change these keymaps to better ones
      move = {
        enable = true,
        -- Whether to set jumps in the jumplist
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = { query = '@parameter.inner', desc = 'Swap with next [a]rgument' },
        },
        swap_previous = {
          ['<leader>A'] = { query = '@parameter.inner', desc = 'Swap with previous [A]rgument' },
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
