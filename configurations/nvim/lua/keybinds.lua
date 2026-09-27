local M = {}

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Universal window navigation (normal mode, all buffer types: vim splits, neo-tree, terminal)
map("n", "<A-h>", "<C-w>h", { desc = "Focus window left" })
map("n", "<A-j>", "<C-w>j", { desc = "Focus window down" })
map("n", "<A-k>", "<C-w>k", { desc = "Focus window up" })
map("n", "<A-l>", "<C-w>l", { desc = "Focus window right" })

-- Neotree
map("n", "<A-f>", "<cmd>Neotree toggle<CR>", opts)
vim.keymap.set({ "n", "v" }, "<A-e>", function()
  if vim.bo.filetype == "neo-tree" then
    vim.cmd("wincmd p")
  else
    vim.cmd("Neotree focus")
  end
end, { desc = "Neotree smart focus toggle" })

-- LSP keybinds
M.lsp_keymaps = function(bufnr)
  local buf_opts = { buffer = bufnr, remap = false, silent = true }
  map('n', 'K', vim.lsp.buf.hover)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', 'go', vim.lsp.buf.type_definition)
  map('n', 'gr', vim.lsp.buf.references)
  map('n', 'gs', vim.lsp.buf.signature_help)
  map('n', 'gl', vim.diagnostic.open_float)
  map('n', '<F2>', vim.lsp.buf.rename)
  map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
  map('n', '<F4>', vim.lsp.buf.code_action)
end

return M
