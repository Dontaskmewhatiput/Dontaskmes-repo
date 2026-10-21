-- lua/plugins/terminal.lua
return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-_>]],
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

    -- Back to normal mode
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "toggleterm",
      callback = function()
        local topts = { buffer = 0, silent = true }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], topts)
        vim.keymap.set("n", "<C-[>", [[<C-\><C-n>]], topts)
      end,
    })

    -- Ctrl + hjkl moves focus
    -- Ctrl + hjkl moves focus in normal mode only
    for _, key in ipairs({ "h", "j", "k", "l" }) do
      vim.keymap.set("n", "<C-" .. key .. ">", "<C-w>" .. key, { silent = true })
    end
  end,
}
