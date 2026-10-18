return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    terminal = {
      win = {
        style = "float",
        border = "rounded",
      },
    },
  },
  keys = {
    {
      "<C-\\>",
      function() Snacks.terminal() end,
      desc = "Toggle terminal",
      mode = { "n", "t" },
    },
  },
}
