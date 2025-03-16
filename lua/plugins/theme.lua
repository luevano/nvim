return {
  {
    'gbprod/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('nord').setup({
        transparent = false, -- controled with below plugin 'xiyaowong/transparent.nvim'
        terminal_colors = true,
        diff = { mode = 'bg' },
        borders = true,
        errors = { mode = 'bg' },
        search = { theme = 'vim' },

        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = {},
          functions = {},
          variables = {},
          errors = {},

          -- To customize lualine/bufferline
          bufferline = {
            current = {},
            modified = { italic = true },
          },
        },

        -- Definitions from the old nord theme I was using:
        -- https://github.com/shaunsingh/nord.nvim/blob/master/lua/nord/theme.lua
        on_highlights = function(hl, c)
          -- Treesitter: https://github.com/gbprod/nord.nvim/blob/main/lua/nord/treesitter.lua
          -- old theme was in yellow, changed the default to purple to match better the newer theme
          hl["@constant"] = { fg = c.aurora.purple }
        end,
      })

      vim.cmd.colorscheme('nord')
    end,
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup({
        extra_groups = {
          -- 'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
        },
        exclude_groups = { 'CursorLine' },
      })
      vim.keymap.set('n', '<leader>tT', '<CMD>TransparentToggle<CR>', { desc = '[t]oggle [T]ransparency' })
    end,
  },
}
