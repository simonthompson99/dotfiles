---@type MappingsTable
--
require("custom.functions")

local M = {}

M.general = {
  n = {

    -- yank filepaths
    ["<leader>yf"] = {"<cmd>YankFilename<CR>", "Yank filename" },
    ["<leader>yd"] = {"<cmd>YankDirectory<CR>", "Yank directory" },
    ["<leader>yp"] = {"<cmd>YankAbsolutePath<CR>", "Yank path" },
    ["<leader>yr"] = {"<cmd>YankRelativePath<CR>", "Yank relative path" },

    ['<leader>tt'] = { "<cmd>vsp<CR><cmd>IronReplHere<CR>", "Start REPL" },
    ['<leader>tl'] = { "<cmd>SendLineToREPL<CR>", "Send Line"},
    ['<leader>tp'] = { "<cmd>SendParagraphToREPL<CR>", "Send paragraph"},
    ['<leader>tf'] = { "<cmd>SendFunctionToREPL<CR>", "Send function"},
    ['<leader>tx'] = { "<cmd>CloseREPL<CR>", "Close REPL"},
    ['<leader>tz'] = { "<cmd>ToggleTerm direction=float<CR>", "Start zsh terminal" },

  },

  v = {
    ["<leader>ts"] = {"<cmd>SendSelectionToREPL<CR>", "Send selection to REPL"},
    ["<leader>yy"] = {"<Esc><cmd>YankSelectionToSystemReg<CR>", "Yank to system clipboard"},
  }
}

-- more keybinds!

local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- insert empty line above and below in normal
keymap("n", "zj", "o<ESC>k", default_opts)
keymap("n", "zk", "O<ESC>j", default_opts)

-- semi-colon to enter command
keymap("n", ";", ":", default_opts)
keymap("v", ";", ":", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

-- get out of terminal
keymap("t", "<ESC>", "<C-\\><C-n>", default_opts)


return M
