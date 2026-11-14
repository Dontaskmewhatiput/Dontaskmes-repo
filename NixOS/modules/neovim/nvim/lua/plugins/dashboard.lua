-- lua/plugins/alpha.lua
return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      "   ██╗  ██╗███████╗██╗  ██╗██╗   ██╗██╗███╗   ███╗   ",
      "   ██║  ██║██╔════╝╚██╗██╔╝██║   ██║██║████╗ ████║   ",
      "   ███████║█████╗   ╚███╔╝ ██║   ██║██║██╔████╔██║   ",
      "   ██╔══██║██╔══╝   ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║   ",
      "   ██║  ██║███████╗██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║   ",
      "   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝   ",
    }

    dashboard.section.buttons.val = {
      dashboard.button("f", "  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("e", "  New File", "<cmd>ene <BAR> startinsert<CR>"),
      dashboard.button("r", "󰄉  Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("g", "󰈞  Find Text", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("c", "  Configuration", "<cmd>e $MYVIMRC<CR>"),
      dashboard.button("u", "󰚰  Update Plugins", "<cmd>Lazy sync<CR>"),
      dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
    }

    local stats = require("lazy").stats()
    dashboard.section.footer.val = "⚡ Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins"

    require("alpha").setup(dashboard.opts)
  end,
}
