-- nvim-treesitter `main` branch: required on Neovim 0.12+ (`master` is frozen at 0.11).
-- Modules are gone: highlight/indent/folds are Neovim's, keymaps are plain keymaps.
local langs = {
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
}

local no_indent = { cpp = true, python = true, css = true }

local function move(fn, query)
  return function()
    require('nvim-treesitter-textobjects.move')[fn](query, 'textobjects')
  end
end

local function select(query)
  return function()
    require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
  end
end

-- Replaces the `incremental_selection` module, dropped with the rest of them on `main`.
local nodes = {}

local function visual_select(node)
  local sr, sc, er, ec = node:range()
  if ec == 0 then -- node ends at col 0 of the next line; back up to the real last char
    er = er - 1
    ec = #(vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1] or '')
  end
  vim.fn.setpos("'<", { 0, sr + 1, sc + 1, 0 })
  vim.fn.setpos("'>", { 0, er + 1, ec, 0 })
  vim.cmd('normal! gv')
end

local function node_init()
  local node = vim.treesitter.get_node()
  if not node then
    return
  end
  nodes = { node }
  visual_select(node)
end

local function node_incremental()
  local node = nodes[#nodes]
  if not node then
    return node_init()
  end
  local parent = node:parent()
  while parent and vim.deep_equal({ parent:range() }, { node:range() }) do
    parent = parent:parent()
  end
  if parent then
    nodes[#nodes + 1] = parent
  end
  visual_select(nodes[#nodes])
end

local function node_decremental()
  if #nodes > 1 then
    table.remove(nodes)
  end
  if nodes[#nodes] then
    visual_select(nodes[#nodes])
  end
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install(langs)

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          if not pcall(vim.treesitter.start, ev.buf) then
            return
          end
          if not no_indent[ev.match] then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      vim.keymap.set('n', '<cr>', node_init, { desc = 'Init selection' })
      vim.keymap.set('x', '<tab>', node_incremental, { desc = 'Increment selection' })
      vim.keymap.set('x', '<s-tab>', node_decremental, { desc = 'Decrement selection' })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      select = {
        lookahead = true,
        include_surrounding_whitespace = false,
      },
      move = { set_jumps = true },
    },
    keys = {
      { 'aa', select('@parameter.outer'), mode = { 'x', 'o' }, desc = 'a parameter' },
      { 'ia', select('@parameter.inner'), mode = { 'x', 'o' }, desc = 'inner parameter' },
      { 'af', select('@function.outer'), mode = { 'x', 'o' }, desc = 'a function' },
      { 'if', select('@function.inner'), mode = { 'x', 'o' }, desc = 'inner function' },
      { 'ac', select('@class.outer'), mode = { 'x', 'o' }, desc = 'a class' },
      { 'ic', select('@class.inner'), mode = { 'x', 'o' }, desc = 'inner class' },

      { ']m', move('goto_next_start', '@function.outer'), mode = { 'n', 'x', 'o' }, desc = 'Next function start' },
      { ']]', move('goto_next_start', '@class.outer'), mode = { 'n', 'x', 'o' }, desc = 'Next class start' },
      { ']M', move('goto_next_end', '@function.outer'), mode = { 'n', 'x', 'o' }, desc = 'Next function end' },
      { '][', move('goto_next_end', '@class.outer'), mode = { 'n', 'x', 'o' }, desc = 'Next class end' },
      { '[m', move('goto_previous_start', '@function.outer'), mode = { 'n', 'x', 'o' }, desc = 'Previous function start' },
      { '[[', move('goto_previous_start', '@class.outer'), mode = { 'n', 'x', 'o' }, desc = 'Previous class start' },
      { '[M', move('goto_previous_end', '@function.outer'), mode = { 'n', 'x', 'o' }, desc = 'Previous function end' },
      { '[]', move('goto_previous_end', '@class.outer'), mode = { 'n', 'x', 'o' }, desc = 'Previous class end' },

      {
        '<leader>a',
        function()
          require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
        end,
        desc = 'Swap with next [a]rgument',
      },
      {
        '<leader>A',
        function()
          require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
        end,
        desc = 'Swap with previous [A]rgument',
      },
    },
  },
}
