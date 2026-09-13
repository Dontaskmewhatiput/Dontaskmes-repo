local M = {}

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Terminal toggle
vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

-- Universal window navigation (normal mode, all buffer types: vim splits, neo-tree, terminal)
map("n", "<A-h>", "<C-w>h", { desc = "Focus window left" })
map("n", "<A-j>", "<C-w>j", { desc = "Focus window down" })
map("n", "<A-k>", "<C-w>k", { desc = "Focus window up" })
map("n", "<A-l>", "<C-w>l", { desc = "Focus window right" })

return M
