return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add cursors up/down
    set({"n", "x"}, "<Up>", function() mc.lineAddCursor(-1) end)
    set({"n", "x"}, "<Down>", function() mc.lineAddCursor(1) end)
    set({"n", "x"}, "<leader><Up>", function() mc.lineSkipCursor(-1) end)
    set({"n", "x"}, "<leader><Down>", function() mc.lineSkipCursor(1) end)

    -- Match word/selection under cursor, forward/backward
    set({"n", "x"}, "<C-n>", function() mc.matchAddCursor(1) end)
    set({"n", "x"}, "<C-p>", function() mc.matchAddCursor(-1) end)
    set({"n", "x"}, "<leader>n", function() mc.matchSkipCursor(1) end)
    set({"n", "x"}, "<leader>N", function() mc.matchSkipCursor(-1) end)

    -- Add a cursor for every match in the document (this is the one from the video)
    set({"n", "x"}, "<leader>A", mc.matchAllAddCursors)

    -- Mouse
    set("n", "<C-LeftMouse>", mc.handleMouse)
    set("n", "<C-LeftDrag>", mc.handleMouseDrag)
    set("n", "<C-LeftRelease>", mc.handleMouseRelease)

    -- Add cursor for each line of a visual selection or text object
    set({"n", "x"}, "ga", mc.addCursorOperator)

    -- Clone every cursor and disable the originals
    set({"n", "x"}, "<leader><C-q>", mc.duplicateCursors)

    -- Align cursor columns
    set("n", "<leader><C-a>", mc.alignCursors)

    -- Split/match visual selections by regex
    set("x", "S", mc.splitCursors)
    set("x", "M", mc.matchCursors)

    -- Restore cursors if cleared accidentally
    set("n", "<leader>gv", mc.restoreCursors)

    -- Transpose text between cursors
    set("x", "<leader>t", function() mc.transposeCursors(1) end)
    set("x", "<leader>T", function() mc.transposeCursors(-1) end)

    -- Increment/decrement sequences across all cursors
    set({"n", "x"}, "g<C-a>", mc.sequenceIncrement)
    set({"n", "x"}, "g<C-x>", mc.sequenceDecrement)

    -- Search-based cursors
    set("n", "<leader>/n", function() mc.searchAddCursor(1) end)
    set("n", "<leader>/N", function() mc.searchAddCursor(-1) end)
    set("n", "<leader>/s", function() mc.searchSkipCursor(1) end)
    set("n", "<leader>/S", function() mc.searchSkipCursor(-1) end)
    set("n", "<leader>/A", mc.searchAllAddCursors)

    -- Escape clears cursors and returns to single-cursor mode
    set({"n", "x"}, "<Esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      else
        -- fallback to normal <Esc> behavior
        vim.cmd("nohlsearch")
      end
    end)

    -- Standard cursor styling, so virtual cursors are visible with your theme
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorMatchPreview", { link = "Search" })
    hl(0, "MultiCursorDisabledCursor", { reverse = true })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
