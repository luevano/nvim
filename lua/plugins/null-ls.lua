return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.clang_format,
        -- gdtoolkit needs to be installed manually (at least in windows, for now)
        null_ls.builtins.formatting.gdformat,
        null_ls.builtins.diagnostics.gdlint,
        -- should use ruff-lsp
        -- null_ls.builtins.formatting.autopep8,
        -- null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.diagnostics.mypy.with({
          extra_args = function()
            local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
            return { "--python-executable", virtual .. "/bin/python" }
          end,
        }),
        -- bash/sell
        null_ls.builtins.formatting.shfmt,
      },
    })
  end
}
