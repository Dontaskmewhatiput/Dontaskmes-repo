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
    -- Servers that Mason installs.
    local mason_servers = {
      'lua_ls', 'clangd', 'rust_analyzer', 'gopls',
      'html', 'cssls', 'ts_ls', 'jsonls', 'nil_ls',
      'bashls', 'docker_language_server', 'marksman', 'taplo', 'yamlls', 'sqlls',
      'basedpyright', 'ruff', 'terraformls',
    }

    -- Servers you install yourself (pacman, cargo, nix, and so on).
    -- Use the names of your lsp/*.lua files. Each one is skipped when its
    -- binary is missing. Add php, c3, d, and the rest here.
    local path_servers = { 'zls', 'hls', 'templ' }

    -- jdtls is installed by Mason but started by nvim-jdtls (lua/plugins/jdtls.lua).
    local mason_install = vim.list_extend(vim.deepcopy(mason_servers), { 'jdtls' })

    -- mason.setup() puts Mason's bin/ directory on $PATH.
    -- The availability check below depends on that.
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = mason_install,
      automatic_enable = false,
    })

    -- Native LSP global defaults (Neovim 0.11+)
    vim.lsp.config('*', {
      root_markers = { '.git' },
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- Per-server settings. Each call merges with the server default.
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
          -- Ruff organizes imports.
          disableOrganizeImports = true,
        },
      },
    })

    vim.lsp.config('yamlls', {
      settings = {
        yaml = {
          -- SchemaStore.nvim supplies the schemas.
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
    vim.lsp.config('docker_language_server', {
      init_options = {
        dockercomposeExperimental = { composeSupport = true },
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

    local orig = vim.lsp.util.open_floating_preview
    ---@diagnostic disable-next-line: duplicate-set-field
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts            = opts or {}
      opts.border     = opts.border or 'rounded'
      opts.max_width  = opts.max_width or 80
      opts.max_height = opts.max_height or 24
      opts.wrap       = opts.wrap ~= false
      return orig(contents, syntax, opts, ...)
    end

    -- Autocmd for keybinds and features attached to LSP buffers
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('my.lsp', {}),
      callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local buf    = args.buf
        local map    = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

        -- Neovim 0.11 already maps these globally:
        --   grr references, gri implementation, grn rename,
        --   gra code action, grt type definition, gO document symbols.
        -- A buffer-local `gr` or `gi` would make Neovim wait out 'timeoutlen'
        -- (gr) or hide the built-in `gi` (insert at last insert position).
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

        -- Basedpyright handles hover. Ruff would duplicate it.
        if client.name == 'ruff' then
          client.server_capabilities.hoverProvider = false
        end



        if client:supports_method('textDocument/documentHighlight') then
          local highlight_augroup = vim.api.nvim_create_augroup('my.lsp.highlight', { clear = false })
          -- Clear first. Two servers on one buffer would add each autocmd twice.
          vim.api.nvim_clear_autocmds({ buffer = buf, group = highlight_augroup })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
        end

        local excluded_filetypes = { php = true, c = true, cpp = true }
        if not client:supports_method('textDocument/willSaveWaitUntil')
            and client:supports_method('textDocument/formatting')
            and not excluded_filetypes[vim.bo[buf].filetype]
        then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
            buffer = buf,
            callback = function()
              vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
            end,
          })
        end
      end,
    })

    vim.filetype.add({
      extension = {
        h = 'c',
        c3 = 'c3',
        d = 'd',
        templ = 'templ',
        -- Podman
        container = 'systemd',
        volume = 'systemd',
        network = 'systemd',
        pod = 'systemd',
      },
      filename = {
        ['Containerfile'] = 'dockerfile',
      },
      pattern = {
        ['Containerfile%..*'] = 'dockerfile',
        -- Podman compose files use the same schema as docker-compose
        ['podman%-compose%.ya?ml'] = 'yaml.docker-compose',
        ['podman%-compose%..*%.ya?ml'] = 'yaml.docker-compose',
      },
    })

    -- Enable a server only when its binary exists.
    -- A missing server never raises a spawn error.
    -- Mason installs run in the background, so restart Neovim once after the
    -- first install. Run :LspMissing to list skipped servers.
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

    vim.api.nvim_create_user_command('LspMissing', function()
      if #missing == 0 then
        vim.notify('All configured LSP servers are available')
      else
        vim.notify('LSP servers not found: ' .. table.concat(missing, ', '), vim.log.levels.WARN)
      end
    end, {})
  end,
}
