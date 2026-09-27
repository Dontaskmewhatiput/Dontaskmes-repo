-- lua/plugins/dap.lua
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Mason installs and wires up adapters automatically.
    -- handlers = {} is what turns on the automatic wiring below; without it,
    -- mason-nvim-dap installs the binaries but never registers them with dap.
    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb", "delve", "js", "bash", "local-lua-debugger-vscode" },
      automatic_installation = true,
      handlers = {},
    })

    dapui.setup()

    -- Open/close the UI in step with the debug session
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Launch configuration for C and C++
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
      },
    }
    dap.configurations.c = dap.configurations.cpp

    dap.configurations.rust = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        sourceLanguages = { "rust" },
      },
    }

    -- Go, JS/TS, and Bash configurations are provided by mason-nvim-dap's
    -- default handlers (enabled via handlers = {} above) and need no manual
    -- dap.configurations entries here.

    -- Keymaps
    vim.keymap.set("n", "<F5>", dap.continue)
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
    vim.keymap.set("n", "<F10>", dap.step_over)
    vim.keymap.set("n", "<F11>", dap.step_into)
    vim.keymap.set("n", "<F12>", dap.step_out)
    vim.keymap.set("n", "<leader>dr", dap.repl.open)
    vim.keymap.set("n", "<leader>du", dapui.toggle)
  end,
}
