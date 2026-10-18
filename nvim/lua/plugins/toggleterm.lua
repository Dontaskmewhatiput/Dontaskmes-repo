-- lua/plugins/dap.lua
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "mason-org/mason.nvim",
  },
  -- The plugin loads on the first key press.
  -- F10 and F11 are grabbed by some terminals, so every F key has a leader twin.
  keys = {
    { "<F5>",       function() require("dap").continue() end,                                  desc = "DAP continue" },
    { "<F9>",       function() require("dap").toggle_breakpoint() end,                         desc = "DAP toggle breakpoint" },
    { "<F10>",      function() require("dap").step_over() end,                                 desc = "DAP step over" },
    { "<F11>",      function() require("dap").step_into() end,                                 desc = "DAP step into" },
    { "<F12>",      function() require("dap").step_out() end,                                  desc = "DAP step out" },

    { "<leader>dc", function() require("dap").continue() end,                                  desc = "DAP continue" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                         desc = "DAP toggle breakpoint" },
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "DAP conditional breakpoint" },
    { "<leader>do", function() require("dap").step_over() end,                                 desc = "DAP step over" },
    { "<leader>di", function() require("dap").step_into() end,                                 desc = "DAP step into" },
    { "<leader>dO", function() require("dap").step_out() end,                                  desc = "DAP step out" },
    { "<leader>dt", function() require("dap").terminate() end,                                 desc = "DAP terminate" },
    { "<leader>dl", function() require("dap").run_last() end,                                  desc = "DAP run last" },
    { "<leader>dr", function() require("dap").repl.open() end,                                 desc = "DAP REPL" },
    { "<leader>du", function() require("dapui").toggle() end,                                  desc = "DAP UI toggle" },
    { "<leader>de", function() require("dapui").eval() end,                                    mode = { "n", "v" },                desc = "DAP eval" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- mason-nvim-dap takes dap adapter names, not Mason package names.
    -- "local-lua-debugger-vscode" is a package name and is not a valid entry.
    -- handlers = {} turns on the automatic adapter setup.
    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb", "delve", "js", "bash" },
      automatic_installation = true,
      handlers = {},
    })

    require("nvim-dap-virtual-text").setup({
      -- Hide secrets and keys
      display_callback = function(variable)
        local name = string.lower(variable.name)
        local value = string.lower(variable.value)
        if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
          return "*****"
        end

        if #variable.value > 15 then
          return " " .. string.sub(variable.value, 1, 15) .. " ... "
        end

        return " " .. variable.value
      end,
    })

    dapui.setup()

    -- Open the UI before launch so the console window exists when the
    -- adapter asks for a terminal. Close it when the session ends.
    dap.listeners.before.attach["dapui_config"] = function() dapui.open() end
    dap.listeners.before.launch["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

    -- terminal = "integrated" runs the program in the dap-ui console window.
    -- Programs that read stdin (scanf, std::cin) need it.
    -- Build with -g, or codelldb has no symbols to stop on.
    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        terminal = "integrated",
      },
    }
    dap.configurations.c = dap.configurations.cpp

    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        terminal = "integrated",
        sourceLanguages = { "rust" },
      },
    }

    -- Go, JS/TS, and Bash configurations come from the mason-nvim-dap handlers.
    -- Java comes from nvim-jdtls (see lua/plugins/jdtls.lua).
  end,
}
