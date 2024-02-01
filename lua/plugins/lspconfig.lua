local servers = {
  gopls = { -- just the key for the gopls config
    gopls = { -- settings parameter in lspconfig.setup requires a this table with another "gopls" name
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      gofumpt = true
    },
  },
  rust_analyzer = {
    cargo = {
      allFeatures = true,
    },
  },
  -- jedi_language_server = {},
  pyright = {},
  lua_ls = {
    Lua = {
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- need to check if there is a better directory
          os.getenv('HOME') .. '/.local/lib/lua',
        }
      },
    },
  }
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    -- Required for the keybinds
    'nvim-telescope/telescope.nvim',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason = require('mason')
    local mason_lspconfig = require('mason-lspconfig')

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local on_attach = function(_, bufnr) -- _ is client
      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })

      -- autoformatting on save from: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
      -- pretty sure this will autoformat any code
      -- temporarily disabled as using the keymap is better so far, else a lot of unnecessary changes will be made to random files (such as thesenvim configs)
      -- local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
      -- if client.supports_method('textDocument/formatting') then
      --   vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      --   vim.api.nvim_create_autocmd('BufWritePre', {
      --     group = augroup,
      --     buffer = bufnr,
      --     callback = function()
      --       vim.cmd('Format')
      --     end,
      --   })
      -- end

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>f', '<CMD>Format<CR>', '[F]ormat')
      nmap('<leader>R', '<CMD>LspRestart<CR>', '[R]estart (lsp)')
      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- See `:help K` for why this keymap
      nmap('<leader>k', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<leader>K', vim.lsp.buf.signature_help, 'Signature Documentation')

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')
    end

    mason.setup({})
    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
          })
        end,
      }
    })

    -- At the end, add GDscript support, which is only supported by lspconfig itself
    lspconfig.gdscript.setup({capabilities = capabilities})
  end,
}
