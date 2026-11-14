-- lua/plugins/gitsigns.lua
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "┃" },
      change       = { text = "┃" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
    current_line_blame = true, -- Shows inline git blame at the end of the current line
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Hunk Navigation
      map("n", "]h", gs.next_hunk, "Next Git Hunk")
      map("n", "[h", gs.prev_hunk, "Previous Git Hunk")

      -- Hunk Actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage Hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset Hunk")
      map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Selected Lines")
      map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Selected Lines")
      map("n", "<leader>hp", gs.preview_hunk, "Preview Hunk Diff")
      map("n", "<leader>hb", gs.blame_line, "Full Git Blame Line")
    end,
  },
}
