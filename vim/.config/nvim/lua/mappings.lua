require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map({ "n", "v" }, ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")


map({ "n", "i", "v" }, "<C-h>", "<cmd>NvimTmuxNavigateLeft<cr>")
map({ "n", "i", "v" }, "<C-l>", "<cmd>NvimTmuxNavigateRight<cr>")
map({ "n", "i", "v" }, "<C-k>", "<cmd>NvimTmuxNavigateUp<cr>")
map({ "n", "i", "v" }, "<C-j>", "<cmd>NvimTmuxNavigateDown<cr>")

-- Better indent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Resizing panes
map("n", "<Left>", ":vertical resize +1<CR>")
map("n", "<Right>", ":vertical resize -1<CR>")
map("n", "<Up>", ":resize -1<CR>")
map("n", "<Down>", ":resize +1<CR>")

-- get out of terminal
map("t", "<ESC>", "<C-\\><C-n>")

-- insert empty line above and below in normal
map("n", "zj", "o<ESC>k")
map("n", "zk", "O<ESC>j")

-- activate lazygit
map("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Start Lazygit"})

-- copy to system clipboard
map("v", "Y", '"+y')

-- REPL maps
map("n", "<leader>tt", "<cmd>vsp<CR><cmd>IronReplHere<CR>", { desc = "Start REPL" })
map("n", "<leader>tl", "<cmd>SendLineToREPL<CR>", { desc = "Send Line to REPL" })
map("n", "<leader>tp", "<cmd>SendParagraphToREPL<CR>", { desc = "Send paragraph to REPL" })
map("n", "<leader>tx", "<cmd>CloseREPL<CR>", { desc = "Close REPL"})
map("n", "<leader>tz", "<cmd>ToggleTerm direction=float<CR>", { desc = "Start zsh terminal" })
map("v", "<leader>ts", "<cmd>SendSelectionToREPL<CR>", { desc = "Send selection to REPL" })

-- yank filenames and directories
map("n", "<leader>yf", "<cmd>YankFilename<CR>", { desc = "Yank filename" })
map("n", "<leader>yd", "<cmd>YankDirectory<CR>", { desc = "Yank directory" })
map("n", "<leader>yp", "<cmd>YankAbsolutePath<CR>", { desc = "Yank path" })
map("n", "<leader>yr", "<cmd>YankRelativePath<CR>", { desc = "Yank relative path" })
