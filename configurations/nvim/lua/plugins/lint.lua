-- lua/plugins/lint.lua
return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- REQUIRED: this is what adds Mason's bin/ dir to Neovim's $PATH.
    -- Without it, mason-tool-installer installs packages but nvim-lint
    -- can never find the binaries.
    require("mason").setup()

    require("mason-tool-installer").setup({
      ensure_installed = {
        "luacheck",           -- lua_ls
        "checkstyle",         -- jdtls
        "golangci-lint",      -- gopls
        "stylelint",          -- cssls / css / scss / less
        "eslint_d",           -- ts_ls
        "jsonlint",           -- jsonls
        "statix",             -- nil_ls
        "shellcheck",         -- bashls
        "hadolint",           -- docker_language_server
        "markdownlint",       -- marksman
        "yamllint",           -- yamlls
        "sqlfluff",           -- sqlls
        "java-debug-adapter", -- jdtls debug bundle (see lua/plugins/jdtls.lua)
        "java-test",          -- jdtls debug bundle (see lua/plugins/jdtls.lua)
        -- "tidy" is NOT in the Mason registry. html linting via Mason
        -- isn't available; either drop html linting or install `tidy`
        -- yourself outside Mason. Left out of linters_by_ft below.
      },
    })

    local lint = require("lint")

    lint.linters_by_ft = {
      lua        = { "luacheck" },
      java       = { "checkstyle" },
      go         = { "golangcilint" },
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
      -- html removed: no Mason-managed linter available (see note above)
    }

    -- checkstyle needs an explicit ruleset or it errors immediately.
    -- Swap "/google_checks.xml" for "/sun_checks.xml" or your own ruleset path.
    lint.linters.checkstyle.args = { "-c", "/google_checks.xml" }

    -- sqlfluff needs an explicit dialect or it fails to parse most SQL.
    -- Change "postgres" to whatever dialect you actually use
    -- (mysql, sqlite, snowflake, bigquery, etc.)
    lint.linters.sqlfluff.args = { "lint", "--format", "json", "--dialect", "postgres" }

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("my.lint", { clear = true }),
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
