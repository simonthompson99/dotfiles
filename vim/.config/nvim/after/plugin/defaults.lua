local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
--opt.clipboard = "unnamedplus" -- Access system clipboard
opt.cmdheight = 2 -- double line for command bit
opt.wrap = true -- allow wrapping
opt.linebreak = true -- prevent wrapping in middle of a word
opt.scrolloff=999 -- keep cursor in the middle of the screen
opt.foldlevel = 20 -- treesitter based-folding
opt.foldmethod = "expr" -- treesitter based-folding
opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesitter based-folding

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
