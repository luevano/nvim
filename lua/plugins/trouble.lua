return {
  'folke/trouble.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- these are just the default configs for reference
  opts = {
    position = "bottom", -- can be: bottom, top, left, right
    height = 10,
    width = 50,
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
    fold_open = "",
    fold_closed = "",
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    cycle_results = true, -- cycle item list when reaching beginning or end of list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    action_keys = {
      close = "q",                                 -- close the list
      cancel = "<esc>",                            -- cancel the preview and get back to your last window / buffer / cursor
      refresh = "r",                               -- manually refresh
      jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
      open_split = { "<c-x>" },                    -- open buffer in new split
      open_vsplit = { "<c-v>" },                   -- open buffer in new vsplit
      open_tab = { "<c-t>" },                      -- open buffer in new tab
      jump_close = { "o" },                        -- jump to the diagnostic and close the list
      toggle_mode = "m",                           -- toggle between "workspace" and "document" diagnostics mode
      switch_severity = "s",                       -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
      toggle_preview = "P",                        -- toggle auto_preview
      hover = "K",                                 -- opens a small popup with the full multiline message
      preview = "p",                               -- preview the diagnostic location
      open_code_href = "c",                        -- if present, open a URI with more information about the diagnostic error
      close_folds = { "zM", "zm" },                -- close all folds
      open_folds = { "zR", "zr" },                 -- open all folds
      toggle_fold = { "zA", "za" },                -- toggle fold of current file
      previous = "k",                              -- previous item
      next = "j",                                  -- next item
      help = "?",                                  -- help menu
    },

    multiline = true,                   -- render multi-line messages
    indent_lines = true,                -- add an indent guide below the fold icons
    win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
    auto_open = false,                  -- automatically open the list when you have diagnostics
    auto_close = false,                 -- automatically close the list when you have no diagnostics
    auto_preview = true,                -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false,                  -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" },  -- for the given modes, automatically jump if there is only a single result
    include_declaration = {
      "lsp_references",
      "lsp_implementations",
      "lsp_definitions"
    }, -- for the given modes, include the declaration of the current symbol in the results
    -- icons / text used for a diagnostic
    signs = {
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "",
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
  },
  config = function(_, opts)
    local trouble = require('trouble')
    trouble.setup(opts)

    -- TODO: get this into a global util, kinda repeated on multiple plugins
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'trouble: ' .. desc
      end
      vim.keymap.set('n', keys, func, { desc = desc })
    end

    -- TODO: do I need all of these?
    nmap("<leader>xx", function() trouble.toggle() end, 'toggle')
    nmap("<leader>xw", function() trouble.toggle("workspace_diagnostics") end, 'toggle [w]orkspace diagnostics')
    nmap("<leader>xd", function() trouble.toggle("document_diagnostics") end, 'toggle [d]ocument diagnostics')
    nmap("<leader>xq", function() trouble.toggle("quickfix") end, 'toggle [q]uickfix')
    nmap("<leader>xl", function() trouble.toggle("loclist") end, 'toggle [l]oclist')
    nmap("gR", function() trouble.toggle("lsp_references") end, '[g]o to (lsp) [R]eference')

    -- TODO: add telescope integration?
    -- taken from https://github.com/folke/trouble.nvim?tab=readme-ov-file#telescope
    -- local actions = require("telescope.actions")
    -- local trouble = require("trouble.providers.telescope")
    --
    -- local telescope = require("telescope")
    --
    -- telescope.setup {
    --   defaults = {
    --     mappings = {
    --       i = { ["<c-t>"] = trouble.open_with_trouble },
    --       n = { ["<c-t>"] = trouble.open_with_trouble },
    --     },
    --   },
    -- }
  end
}
