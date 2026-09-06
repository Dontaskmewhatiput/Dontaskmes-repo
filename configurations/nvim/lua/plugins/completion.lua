return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    opts = {
      keymap = {
        preset = "default",
        -- <CR> accepts: <Tab>/<S-Tab> navigate list
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      sources = {
        default = {"lsp", "path", "snippets", "buffer" },
      },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
      ghost_text = {
        enabled = true,
      },
    },

    signature = {
      enabled = true,
    },
  },
},
}
