-- lua/plugins/jdtls.lua
return {
  "mfussenegger/nvim-jdtls",
  ft = "java",
  dependencies = {
    "mason-org/mason.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    local jdtls = require("jdtls")

    -- Mason 2 removed Package:get_install_path(). Use $MASON instead.
    -- The packages install through mason-tool-installer (see lua/plugins/lint.lua).
    local function bundles()
      local root = vim.fn.expand("$MASON/packages")
      local found = {}

      vim.list_extend(found, vim.split(
        vim.fn.glob(root .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
        "\n", { trimempty = true }
      ))

      -- nvim-jdtls says to leave these two jars out of the bundle list.
      local excluded = {
        ["com.microsoft.java.test.runner-jar-with-dependencies.jar"] = true,
        ["jacocoagent.jar"] = true,
      }
      for _, jar in ipairs(vim.split(vim.fn.glob(root .. "/java-test/extension/server/*.jar"), "\n", { trimempty = true })) do
        if not excluded[vim.fn.fnamemodify(jar, ":t")] then
          table.insert(found, jar)
        end
      end

      return found
    end

    local markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }

    local function attach(buf)
      if vim.fn.executable("jdtls") == 0 then
        return
      end
      jdtls.start_or_attach({
        cmd = { "jdtls" },
        root_dir = vim.fs.root(buf, markers) or vim.fn.getcwd(),
        -- nvim-jdtls does not read vim.lsp.config('*'), so pass capabilities here.
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        init_options = { bundles = bundles() },
        on_attach = function()
          jdtls.setup_dap({ hotcodereplace = "auto" })
          -- Without this call, F5 finds no Java launch configuration.
          require("jdtls.dap").setup_dap_main_class_configs()
        end,
      })
    end

    -- Attach on every java buffer, not only the first one.
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("my.jdtls", { clear = true }),
      pattern = "java",
      callback = function(args)
        attach(args.buf)
      end,
    })
    attach(vim.api.nvim_get_current_buf())
  end,
}
