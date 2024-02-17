-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })

vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")
vim.keymap.set("n", "K", "<cmd>bnext<cr>")
vim.keymap.set("n", "J", "<cmd>bprevious<cr>")
vim.keymap.set("n", "]<Tab>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[<Tab>", "<cmd>tabprevious<cr>")

vim.keymap.set("x", "<leader>p", '""dP')
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set("n", "dx", '""dd')
