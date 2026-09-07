local M = {}

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General keymappings
-- Terminal 
vim.keymap.set({ "n", "t" }, "<C-_>", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Neotree
map("n", "<A-f>", "<cmd>Neotree toggle<CR>", opts)
vim.keymap.set({ "n", "v" }, "<A-e>", function ()
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

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<A-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<A-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<A-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<A-l>", [[<Cmd>wincmd l<CR>]], opts)

  map("n", "<A-k>", "<cmd>resize +5<cr>", { desc = "Increase terminal height" })
  map("n", "<A-j>", "<cmd>resize -5<cr>", { desc = "Decrease terminal height" })
  map("n", "<A-h>", "<cmd>vertical resize -5<cr>", { desc = "Decrease terminal width" })
  map("n", "<A-l>", "<cmd>vertical resize +5<cr>", { desc = "Increase terminal width" })
end
end

