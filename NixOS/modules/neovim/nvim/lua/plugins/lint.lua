-- lua/plugins/lint.lua
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
  },
  config = function()
    -- mason-tool-installer block removed to prevent automatic downloads on NixOS.
    -- All linters are now discovered directly from your system $PATH via Nix.

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
