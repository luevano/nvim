return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  -- Defaults https://github.com/nvim-neo-tree/neo-tree.nvim/blob/v2.x/lua/neo-tree/defaults.lua
  -- Most of the options here are the defaults, I just have them to be on top of them
  -- Other cool options would be the way the lists are rendered
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    -- when opening files, do not use windows containing these filetypes or buftypes
    open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
    sort_case_insensitive = false,
    sort_function = nil,
    -- this sorts files and directories descendantly
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end,
    use_popups_for_input = true, -- If false, inputs will use vim.ui.input() instead of custom floats.
    use_default_mappings = true,
    window = {
      position = "left",
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<space>"] = {
          "toggle_node",
          -- disable `nowait` if you have existing combos starting with this char that you want to use
          nowait = false,
        },
        ["<2-LeftMouse>"] = "open",
        ["<cr>"] = "open",
        ["<esc>"] = "revert_preview",
        ["P"] = { "toggle_preview", config = { use_float = true } },
        ["l"] = "focus_preview",
        ["S"] = "open_split",
        -- ["S"] = "split_with_window_picker",
        ["s"] = "open_vsplit",
        -- ["s"] = "vsplit_with_window_picker",
        ["t"] = "open_tabnew",
        -- ["<cr>"] = "open_drop",
        -- ["t"] = "open_tab_drop",
        ["w"] = "open_with_window_picker",
        ["C"] = "close_node",
        ["z"] = "close_all_nodes",
        --["Z"] = "expand_all_nodes",
        ["R"] = "refresh",
        ["a"] = {
          "add",
          config = {
            -- "none", "relative", "absolute"
            show_path = "none",
          },
        },
        -- also accepts the config.show_path and config.insert_as options.
        ["A"] = "add_directory",
        ["d"] = "delete",
        ["r"] = "rename",
        ["y"] = "copy_to_clipboard",
        ["x"] = "cut_to_clipboard",
        ["p"] = "paste_from_clipboard",
        -- takes text input for destination, also accepts the config.show_path and config.insert_as options
        ["c"] = "copy",
        -- takes text input for destination, also accepts the config.show_path and config.insert_as options
        ["m"] = "move",
        ["e"] = "toggle_auto_expand_width",
        ["q"] = "close_window",
        ["?"] = "show_help",
        ["<"] = "prev_source",
        [">"] = "next_source",
      },
    },
    default_component_configs = {
      icon = {
        folder_empty = "󰜌",
        folder_empty_open = "󰜌",
      },
      git_status = {
        symbols = {
          renamed   = "󰁕",
          unstaged  = "󰄱",
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        force_visible_in_empty_folder = true,
        show_hidden_count = true,
        hide_dotfiles = true,
        hide_gitignored = true,
        -- Windows only
        hide_hidden = true,
        hide_by_name = {
          -- "node_modules"
        },
        -- uses glob style patterns
        hide_by_pattern = {
          -- "*.meta",
          -- "*/src/*/tsconfig.json",
        },
        always_show = {
          -- ".gitignored",
        },
        never_show = {
          -- ".DS_Store",
          -- "thumbs.db"
        },
        never_show_by_pattern = {
          -- ".null-ls_*",
        },
      },
      follow_current_file = {
        enabled = true
      },
      group_empty_dirs = false,
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = false,
      window = {
        mappings = {
          ["H"] = "toggle_hidden",
          ["/"] = "fuzzy_finder",
          ["D"] = "fuzzy_finder_directory",
          --["/"] = "filter_as_you_type", -- this was the default until v1.28
          ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
          -- ["D"] = "fuzzy_sorter_directory",
          ["f"] = "filter_on_submit",
          ["<C-x>"] = "clear_filter",
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["[g"] = "prev_git_modified",
          ["]g"] = "next_git_modified",
        },
        -- define keymaps for filter popup window in fuzzy_finder_mode
        fuzzy_finder_mappings = {
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
        },
      },
    },
    buffers = {
      bind_to_cwd = true,
      follow_current_file = {
        enabled = true
      },
      group_empty_dirs = true,
      show_unloaded = true,
      window = {
        mappings = {
          ["<bs>"] = "navigate_up",
          ["."] = "set_root",
          ["bd"] = "buffer_delete",
        },
      },
    },
    git_status = {
      window = {
        position = "float",
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gr"] = "git_revert_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
          ["gg"] = "git_commit_and_push",
        }
      }
    },
    document_symbols = {
      follow_cursor = false,
      client_filters = "first",
      renderers = {
        root = {
          {"indent"},
          {"icon", default="C" },
          {"name", zindex = 10},
        },
        symbol = {
          {"indent", with_expanders = true},
          {"kind_icon", default="?" },
          {"container",
            content = {
              {"name", zindex = 10},
              {"kind_name", zindex = 20, align = "right"},
            }
          }
        },
      },
      window = {
        mappings = {
          ["<cr>"] = "jump_to_symbol",
          ["o"] = "jump_to_symbol",
          -- also accepts the config.show_path and config.insert_as options.
          ["A"] = "noop",
          ["d"] = "noop",
          ["y"] = "noop",
          ["x"] = "noop",
          ["p"] = "noop",
          ["c"] = "noop",
          ["m"] = "noop",
          ["a"] = "noop",
          ["/"] = "filter",
          ["f"] = "filter_on_submit",
        },
      },
      custom_kinds = {
        -- ccls
        -- [252] = 'TypeAlias',
        -- [253] = 'Parameter',
        -- [254] = 'StaticMethod',
        -- [255] = 'Macro',
      },
      kinds = {
        Unknown = { icon = "?", hl = "" },
        Root = { icon = "", hl = "NeoTreeRootName" },
        Module = { icon = "", hl = "Exception" },
        Method = { icon = "", hl = "Function" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Interface = { icon = "", hl = "Type" },
        Variable = { icon = "", hl = "@variable" },
        Constant = { icon = "", hl = "Constant" },
        Boolean = { icon = "", hl = "Boolean" },
        Null = { icon = "", hl = "Constant" },
        EnumMember = { icon = "", hl = "Number" },
        Event = { icon = "", hl = "Constant" },
        -- Nerd Fonts v3 fixed
        File = { icon = "󰈙", hl = "Tag" },
        Namespace = { icon = "󰌗", hl = "Include" },
        Package = { icon = "󰏖", hl = "Label" },
        Class = { icon = "󰌗", hl = "Include" },
        Property = { icon = "󰆧", hl = "@property" },
        Enum = { icon = "󰒻", hl = "@number" },
        Function = { icon = "󰊕", hl = "Function" },
        String = { icon = "󰀬", hl = "String" },
        Number = { icon = "󰎠", hl = "Number" },
        Array = { icon = "󰅪", hl = "Type" },
        Object = { icon = "󰅩", hl = "Type" },
        Key = { icon = "󰌋", hl = "" },
        Struct = { icon = "󰌗", hl = "Type" },
        Operator = { icon = "󰆕", hl = "Operator" },
        TypeParameter = { icon = "󰊄", hl = "Type" },
        -- StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        -- ccls, not really needing them yet; related to the above "custom_kinds"
        -- TypeAlias = { icon = ' ', hl = 'Type' },
        -- Parameter = { icon = ' ', hl = '@parameter' },
        -- StaticMethod = { icon = 'ﴂ ', hl = 'Function' },
        -- Macro = { icon = ' ', hl = 'Macro' },
      },
    },
    source_selector = {
      winbar = true,
      statusline = false,
      show_scrolled_off_parent_node = false,
      -- These require a space on the sides for aesthetic reasons
      sources = {
        { source = "filesystem", display_name = " 󰉓 Files " },
        { source = "git_status", display_name = " 󰊢 Git " },
        { source = "buffers", display_name = " 󰈙 Buffs " },
        { source = "document_symbols", display_name = " 󰊕 Symbols " },
      },
      -- only with `tabs_layout` = "equal", "focus"
      content_layout = "start",
      tabs_layout = "equal", -- start, end, center, equal, focus
      truncation_character = "…",
      tabs_min_width = nil,
      tabs_max_width = nil,
      padding = 0,
      -- Default separators, wanted to use powerline icons, but the coloring is all wrong
      separator = { left = "▏", right= "▕" },
      separator_active = nil,
      show_separator_on_edge = false,
      highlight_tab = "NeoTreeTabInactive",
      highlight_tab_active = "NeoTreeTabActive",
      highlight_background = "NeoTreeTabInactive",
      highlight_separator = "NeoTreeTabSeparatorInactive",
      highlight_separator_active = "NeoTreeTabSeparatorActive",
    },
  },
  keys = {
    { '<leader>nt', '<CMD>Neotree toggle<CR>', desc = 'Toggle [N]eo[t]ree' },
  },
}
