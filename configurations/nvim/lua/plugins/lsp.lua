return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
        "bashls",
        "ts_ls",
        "jsonls",
        "rust_analyzer",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp"},
    config = function()
      -- 1. Configure Diagnostics (Inline error highlighting)
      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- 2. Enable standard language servers
      local servers = { "clangd", "pyright", "bashls", "ts_ls", "jsonls", "rust_analyzer" }
      for _, lsp in ipairs(servers) do
        vim.lsp.enable(lsp)
      end

      -- 3. Configure custom language servers (lua_ls)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim" },
            },
            enable = false,
            paramName = "Disable",
            paramType = false,
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")
      vim.lsp.inlay_hint.enable(false)
    end,
  },
}
