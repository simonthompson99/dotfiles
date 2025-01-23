-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

map({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })

-- insert empty line above and below in normal
map("n", "zj", "o<ESC>k")
map("n", "zk", "O<ESC>j")

-- copy to system clipboard
map("v", "Y", '"+y')

map({ "n", "i", "v" }, "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>")
map({ "n", "i", "v" }, "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>")
map({ "n", "i", "v" }, "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>")
map({ "n", "i", "v" }, "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>")

map({ "n" }, "<leader>xd", "<cmd>DiffSave<cr>", { desc = "Diff buffer to saved" })
