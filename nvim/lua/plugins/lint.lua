-- lua/plugins/lint.lua
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "luacheck",         -- lua_ls
        "cppcheck",         -- clangd
        "checkstyle",       -- jdtls
        "golangci-lint",    -- gopls
        "tidy",             -- html
        "stylelint",        -- cssls
        "eslint_d",         -- ts_ls
        "jsonlint",         -- jsonls
        "statix",           -- nil_ls
        "shellcheck",       -- bashls
        "hadolint",         -- docker_language_server
        "markdownlint-cli", -- marksman
        "yamllint",         -- yamlls
        "sqlfluff",         -- sqlls
      },
    })

    local lint = require("lint")

    lint.linters_by_ft = {
      lua        = { "luacheck" },
      c          = { "cppcheck" },
      cpp        = { "cppcheck" },
      java       = { "checkstyle" },
      go         = { "golangcilint" },
      html       = { "tidy" },
      css        = { "stylelint" },
      scss       = { "stylelint" },
      less       = { "stylelint" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      json       = { "jsonlint" },
      nix        = { "statix" },
      sh         = { "shellcheck" },
      bash       = { "shellcheck" },
      dockerfile = { "hadolint" },
      markdown   = { "markdownlint" },
      yaml       = { "yamllint" },
      sql        = { "sqlfluff" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("my.lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
