local keymap = vim.api.nvim_buf_set_keymap
local default_opts = { noremap = true, silent = true }

vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.textwidth = 0
vim.bo.autoindent = true
vim.bo.smartindent = true

keymap(0, "i", ";", " <-", default_opts)
keymap(0, "i", ";;", ";", default_opts)
