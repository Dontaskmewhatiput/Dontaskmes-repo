-- lua/plugins/lint.lua
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- lsp.lua runs mason.setup() at startup, so Mason's bin/ is already on $PATH.
    require("mason-tool-installer").setup({
      ensure_installed = {
        "luacheck",           -- lua
        "checkstyle",         -- java
        "golangci-lint",      -- go
        "stylelint",          -- css, scss, less
        "eslint_d",           -- javascript, typescript
        "jsonlint",           -- json
        "statix",             -- nix
        "shellcheck",         -- sh, bash
        "hadolint",           -- dockerfile
        "markdownlint",       -- markdown
        "yamllint",           -- yaml
        "sqlfluff",           -- sql
        "htmlhint",           -- html
        "tflint",             -- terraform
        "java-debug-adapter", -- jdtls debug bundle (see lua/plugins/jdtls.lua)
        "java-test",          -- jdtls debug bundle (see lua/plugins/jdtls.lua)
      },
    })

    local lint = require("lint")

    lint.linters_by_ft = {
      lua             = { "luacheck" },
      java            = { "checkstyle" },
      go              = { "golangcilint" },
      html            = { "htmlhint" },
      css             = { "stylelint" },
      scss            = { "stylelint" },
      less            = { "stylelint" },
      javascript      = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript      = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      json            = { "jsonlint" },
      nix             = { "statix" },
      sh              = { "shellcheck" },
      bash            = { "shellcheck" },
      dockerfile      = { "hadolint" },
      markdown        = { "markdownlint" },
      yaml            = { "yamllint" },
      sql             = { "sqlfluff" },
      terraform       = { "tflint" },
    }

    -- Keep the default sqlfluff flags. Add only the dialect.
    -- Change "postgres" to mysql, sqlite, snowflake, bigquery, and so on.
    local sqlfluff = lint.linters.sqlfluff
    sqlfluff.args = vim.list_extend(vim.deepcopy(sqlfluff.args or {}), { "--dialect=postgres" })

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("my.lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
