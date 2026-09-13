return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim",
    -- Optional, but nice to have
    "nvim-tree/nvim-web-devicons", -- Nerd fonts required
    { "folke/snacks.nvim", optional = true },
  },
  cmd = "Neotree",
  lazy = false,
  opts = {
    filesystem = {
      filtered_items = {
        visible = false, -- hidden items stay hidden until toggled
        hide_dotfiles = true,
        hide_gitignored = true,
      },
    },
  },
  keys = {
    { "<A-f>", "<cmd>Neotree toggle<CR>", desc = "Toggle Neotree" },
    {
      "<A-e>",
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd("wincmd p")
        else
          vim.cmd("Neotree focus")
        end
      end,
      mode = { "n", "v" },
      desc = "Neotree smart focus toggle",
    },
  },
}
