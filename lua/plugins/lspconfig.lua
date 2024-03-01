local function get_lua_lib()
  if vim.loop.os_uname().sysname == 'Linux' then
    return {
      vim.env.VIMRUNTIME,
      os.getenv('HOME') .. '/.local/lib/lua',
    }
  end
  return {
    vim.env.VIMRUNTIME,
  }
end

local function get_gdscript_cmd()
  local port = os.getenv('GDScript_Port') or '6005'
  if vim.loop.os_uname().sysname == 'Linux' then
    return { 'nc', 'localhost', port }
  end
  return { 'ncat', 'localhost', port }
end

local servers = {
  clangd = {},
  gopls = {   -- just the key for the gopls config
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
  ruff_lsp = {
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      }
    }
  },
  pyright = {},
  lua_ls = {
    Lua = {
      telemetry = { enable = false },
      workspace = {
        checkThirdParty = false,
        library = get_lua_lib(),
      },
    },
  },
  gdscript = {},
}

return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'clangd',
        'clang-format',
        'gopls',
        'rust-analyzer',
        'mypy',
        'ruff-lsp',
        'pyright',
        'lua-language-server',
      },
    },
    config = function(_, opts)
      local mason = require("mason")
      mason.setup(opts)

      -- taken from the nvchad
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})

      vim.g.mason_binaries_list = opts.ensure_installed
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      -- Required for the keybinds
      'nvim-telescope/telescope.nvim',
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      local lspconfig = require('lspconfig')

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- TODO: change keybinds to the autocmd suggested by the lspconfig github
      local on_attach = function(_, bufnr) -- _ is client
        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format({ async = false })
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

      -- generic server setup
      local function setup_server(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        })
      end

      -- setup_server('clangd')
      lspconfig['clangd'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers['clangd'],
        cmd = {
          'clangd',
          -- fixes: multiple different client offset_encodings detected
          '--offset-encoding=utf-16',
        },
      })

      setup_server('gopls')
      setup_server('rust_analyzer')
      setup_server('pyright')
      setup_server('ruff_lsp')
      setup_server('lua_ls')
      -- assumes localhost is mirrored (networkingMode=mirrored in .wslconfig)
      -- setup_server('gdscript')
      lspconfig['gdscript'].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers['gdscript'],
        cmd = get_gdscript_cmd(),
      })
    end,
  },
}
