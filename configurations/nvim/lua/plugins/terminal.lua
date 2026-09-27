-- lua/plugins/terminal.lua
return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-/>]],
      hide_numbers = true,
      shade_terminals = true,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    })

    -- Terminal toggle
    vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

    -- Terminal-mode window navigation
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "toggleterm",
      callback = function()
        local topts = { buffer = 0, silent = true }
        vim.keymap.set("t", "<A-C-h>", [[<C-\><C-n><C-w>h]], topts)
        vim.keymap.set("t", "<A-C-j>", [[<C-\><C-n><C-w>j]], topts)
        vim.keymap.set("t", "<A-C-k>", [[<C-\><C-n><C-w>k]], topts)
        vim.keymap.set("t", "<A-C-l>", [[<C-\><C-n><C-w>l]], topts)
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], topts)
      end,
    })
  end,
}
