local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Shorten function name
local map = vim.api.nvim_set_keymap

-- Remap space as leader key
map("", "<Space>", "<Nop>", opts) -- Disable space key
vim.g.mapleader = " " -- Set space as leader key
vim.g.maplocalleader = " " -- Set space as local leader key

-- Modes
local normal_mode = "n"
local visual_mode = "v"
local visual_block_mode = "x"
local term_mode = "t"

-- Normal mode mappings
map(normal_mode, "<C-h>", "<C-w>h", opts) -- Navigate left
map(normal_mode, "<C-j>", "<C-w>j", opts) -- Navigate down
map(normal_mode, "<C-k>", "<C-w>k", opts) -- Navigate up
map(normal_mode, "<C-l>", "<C-w>l", opts) -- Navigate right

map(normal_mode, "<leader>e", ":Lex 20<CR>", opts) -- Open file explorer
map(normal_mode, "<leader>u", "<C-r>", opts) -- Redo
map(normal_mode, "<leader>w", ":w<CR>", opts) -- Save
map(normal_mode, "<leader>q", ":q<CR>", opts) -- Quit

map(normal_mode, "<C-Up>", ":resize +2<CR>", opts) -- Resize window up
map(normal_mode, "<C-Down>", ":resize -2<CR>", opts) -- Resize window down
map(normal_mode, "<C-Left>", ":vertical resize -2<CR>", opts) -- Resize window left
map(normal_mode, "<C-Right>", ":vertical resize +2<CR>", opts) -- Resize window right

map(normal_mode, "<s-h>", "^", opts) -- Move cursor to the beginning of the line
map(visual_mode, "<s-h>", "^", opts) -- Move selection start to the beginning of the line
map(normal_mode, "<s-l>", "g_", opts) -- Move cursor to the end of the line
map(visual_mode, "<s-l>", "g_", opts) -- Move selection end to the end of the line

map(normal_mode, "<C-a>", "ggVG", opts) -- Select all (beginning to end of the file)
map(normal_mode, "<leader>d", '"_d', opts) -- Select all (beginning to end of the file)

-- Insert mode mappings
map("i", "jk", "<ESC>", opts) -- Quickly exit insert mode by typing jk

-- Visual mode mappings
map(visual_mode, "<", "<gv", opts) -- Indent left
map(visual_mode, ">", ">gv", opts) -- Indent right

map(visual_mode, "<A-j>", ":m '>+1<CR>gv=gv", opts) -- Move selected text down
map(visual_mode, "<A-k>", ":m '<-2<CR>gv=gv", opts) -- Move selected text up
map(visual_mode, "p", '"_dP', opts) -- Paste without yanking text

-- Visual block mode mappings
map(visual_block_mode, "J", ":m '>+1<CR>gv=gv", opts) -- Move block down
map(visual_block_mode, "K", ":m '<-2<CR>gv=gv", opts) -- Move block up
map(visual_block_mode, "<A-j>", ":m '>+1<CR>gv=gv", opts) -- Move block down
map(visual_block_mode, "<A-k>", ":m '<-2<CR>gv=gv", opts) -- Move block up

-- Terminal mode mappings
map(term_mode, "<C-h>", "<C-\\><C-N><C-w>h", term_opts) -- Navigate left in terminal
map(term_mode, "<C-j>", "<C-\\><C-N><C-w>j", term_opts) -- Navigate down in terminal
map(term_mode, "<C-k>", "<C-\\><C-N><C-w>k", term_opts) -- Navigate up in terminal
map(term_mode, "<C-l>", "<C-\\><C-N><C-w>l", term_opts) -- Navigate right in terminal
