-- lua/plugins/jdtls.lua
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "williamboman/mason.nvim",
  },
  config = function()
    local jdtls = require("jdtls")

    local function get_bundles()
      local mason_registry = require("mason-registry")
      local bundles = {}

      local debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path() .. "/extension/server/"
      vim.list_extend(bundles, vim.split(vim.fn.glob(debug_path .. "com.microsoft.java.debug.plugin-*.jar"), "\n"))

      local test_path = mason_registry.get_package("java-test"):get_install_path() .. "/extension/server/"
      vim.list_extend(bundles, vim.split(vim.fn.glob(test_path .. "*.jar"), "\n"))

      return bundles
    end

    local config = {
      cmd = { "jdtls" },
      root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }),
      init_options = {
        bundles = get_bundles(),
      },
      on_attach = function()
        jdtls.setup_dap({ hotcodereplace = "auto" })
      end,
    }

    jdtls.start_or_attach(config)
  end,
}
