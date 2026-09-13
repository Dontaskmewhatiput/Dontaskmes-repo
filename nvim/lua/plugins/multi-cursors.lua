return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    set({ "n", "v" }, "<C-k>", function() mc.addCursor("k") end)
    set({ "n", "v" }, "<C-j>", function() mc.addCursor("j") end)

    set({ "n", "v" }, "<C-n>", function() mc.addCursor("*") end)
    set({ "n", "v" }, "<C-p>", function() mc.addCursor("#") end)

    -- Skip a match without adding a cursor (still moves to it)
    set({ "n", "v" }, "<C-s>", function() mc.skipCursor("*") end)

    -- Add a cursor where the main cursor already is
    set({ "n", "v" }, "<C-space>", function() mc.addCursor() end)

    -- Jumps cursors
    set({ "n", "v" }, "<C-h>", mc.prevCursor)
    set({ "n", "v" }, "<C-l>", mc.nextCursor)

    -- Delete the main cursor
    set({ "n", "v" }, "<C-x>", mc.deleteCursor)

    -- Add/remove cursors with Ctrl + left click
    set("n", "<C-leftmouse>", mc.handleMouse)

    set({ "n", "v" }, "<C-q>", mc.toggleCursor)

    -- In visual mode: insert/append at the start/end of each selection
    set("v", "I", mc.insertVisual)
    set("v", "A", mc.appendVisual)

    -- Match new cursors inside a visual selection using a regex
    set("v", "M", mc.matchCursors)

    -- Escape clears all cursors, or exits normally if none exist
    set({ "n", "v" }, "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        vim.cmd("noh")
      end
    end)
  end,
}
