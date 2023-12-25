return {
  "nvimtools/none-ls.nvim",
  enabled = false,
  dependencies = {
    { "williamboman/mason.nvim", config = true},
    {
      "jay-babu/mason-null-ls.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = {},
    },
  },
  config = function ()
    local mason_nullls = require('mason-null-ls')
    mason_nullls.setup({
      ensure_installed = {
        'gofumpt', -- or gofmt
        'golines',
      },
      automatic_installation = true,
      handlers = {}
    })

    -- autoformatting on save from: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
    -- pretty sure this will autoformat any code
    local nonels = require('null-ls')
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    nonels.setup({
      -- you can reuse a shared lspconfig on_attach callback here
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
              vim.lsp.buf.format({async = false})
            end,
          })
        end
      end,
    })
  end,
}
