-- lua/plugins/lsp.lua
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "b0o/SchemaStore.nvim",
  },
  config = function()
    -- Fully synchronized with Treesitter & DAP languages
    local mason_servers = {
      'lua_ls', 'clangd', 'rust_analyzer', 'gopls',
      'html', 'cssls', 'ts_ls', 'jsonls', 'nil_ls',
      'bashls', 'docker_language_server', 'marksman', 'taplo', 'yamlls', 'sqlls',
      'basedpyright', 'ruff', 'terraformls', 'jdtls', -- Standard LSP server for Java (avoids complex nvim-jdtls boilerplate)
    }

    local path_servers = { 'zls', 'hls', 'templ' }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = mason_servers,
      automatic_enable = false,
    })

    vim.lsp.config('*', {
      root_markers = { '.git' },
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.config('gopls', {
      settings = {
        gopls = {
          gofumpt = true,
          usePlaceholders = true,
          hints = {
            parameterNames = true,
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          check = { command = 'clippy' },
        },
      },
    })

    vim.lsp.config('basedpyright', {
      settings = {
        basedpyright = {
          disableOrganizeImports = true,
        },
      },
    })

    vim.lsp.config('yamlls', {
      settings = {
        yaml = {
          schemaStore = { enable = false, url = '' },
          schemas = require('schemastore').yaml.schemas(),
        },
      },
    })

    vim.lsp.config('jsonls', {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(),
          validate = { enable = true },
        },
      },
    })

    vim.diagnostic.config({
      virtual_text  = true,
      severity_sort = true,
      float         = {
        style  = 'minimal',
        border = 'rounded',
        source = 'if_many',
        header = '',
        prefix = '',
      },
      signs         = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✘',
          [vim.diagnostic.severity.WARN]  = '▲',
          [vim.diagnostic.severity.HINT]  = '⚑',
          [vim.diagnostic.severity.INFO]  = '»',
        },
      },
    })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('my.lsp', {}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local buf    = args.buf
        local map    = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

        map('n', 'K', vim.lsp.buf.hover)
        map('n', 'gd', vim.lsp.buf.definition)
        map('n', 'gD', vim.lsp.buf.declaration)
        map('n', 'go', vim.lsp.buf.type_definition)
        map('n', 'gs', vim.lsp.buf.signature_help)
        map('n', 'gl', vim.diagnostic.open_float)
        map('n', '<F2>', vim.lsp.buf.rename)
        map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
        map('n', '<leader>ca', vim.lsp.buf.code_action)
        map('n', '<leader>ch', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
        end)

        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end
      end,
    })

    local missing = {}
    local function enable_available(names)
      for _, name in ipairs(names) do
        local cmd = (vim.lsp.config[name] or {}).cmd
        local found = type(cmd) == 'function'
            or (type(cmd) == 'table' and vim.fn.executable(cmd[1]) == 1)
        if found then
          vim.lsp.enable(name)
        else
          table.insert(missing, name)
        end
      end
    end

    enable_available(mason_servers)
    enable_available(path_servers)
  end,
}
