return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim",
    -- Optional, but nice to have
    "nvim-tree/nvim-web-devicons", -- Nerd fonts required
    { "folke/snacks.nvim", optional = true},
  },
  cmd = "Neotree",
  opts = {
    filesystem = {
      filtered_items
    },
  lazy = false,
  }
}
