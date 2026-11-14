-- lua/plugins/dap.lua
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "igorlfs/nvim-dap-view",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    local dap = require("dap")
    local dap_view = require("dap-view")

    require("mason-nvim-dap").setup({
      ensure_installed = { 
        "codelldb", 
        "delve",    
        "js",       
        "bash",     
        "python",   
        "java-debug-adapter", 
        "local-lua-debugger-vscode" 
      },
      automatic_installation = true,
      handlers = {},
    })

    require("nvim-dap-virtual-text").setup()
    dap_view.setup()

    -- Open/close the view in step with the debug session
    dap.listeners.after.event_initialized["dap_view_config"] = function()
      dap_view.open()
    end
    dap.listeners.before.event_terminated["dap_view_config"] = function()
      dap_view.close()
    end
    dap.listeners.before.event_exited["dap_view_config"] = function()
      dap_view.close()
    end

    -- Configurations
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
    dap.configurations.rust = dap.configurations.cpp

-- Keymaps
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
    vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })

    -- DAP View Keybindings (using function wrappers to prevent nil errors)
    vim.keymap.set("n", "<leader>dc", function() dap_view.toggle() end, { desc = "Toggle DAP View" })
    vim.keymap.set({ "n", "v" }, "<leader>de", function() dap_view.eval() end, { desc = "DAP View Evaluate" })
    vim.keymap.set("n", "<leader>dw", function() dap_view.add_expr() end, { desc = "DAP View Add Watch Expression" })
    vim.keymap.set("n", "<leader>dr", function() dap.repl.open() end, { desc = "DAP Open REPL" })

  end,
}
