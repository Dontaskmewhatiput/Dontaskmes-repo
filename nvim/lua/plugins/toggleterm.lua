-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  opts = {
    open_mapping = [[<C-/>]],
    direction = "horizontal",
    float_opts = {
      border = "curved",
    },
    shade_terminals = true,
    start_in_insert = true,
    persist_size = true,
    close_on_exit = true,
    shell = vim.o.shell,
  },
}
