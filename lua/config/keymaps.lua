-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })

-- vim.g.sandwich_no_default_key_mappings = 1
-- vim.keymap.set("", "<leader>sa", "<Plug>(sandwich-add)")
-- vim.keymap.set("", "<leader>sd", "<Plug>(sandwich-delete)")
-- vim.keymap.set("", "<leader>sdb", "<Plug>(sandwich-delete-auto)")
-- vim.keymap.set("", "<leader>sr", "<Plug>(sandwich-replace)")
-- vim.keymap.set("", "<leader>srb", "<Plug>(sandwich-replace-auto)")
-- vim.keymap.set("", "<leader>sc", "<Plug>(sandwich-replace)")
-- vim.keymap.set("", "<leader>scb", "<Plug>(sandwich-replace-auto)")
-- vim.keymap.set({ "o", "x" }, "<unique> ib", "(textobj-sandwich-auto-i)")
-- vim.keymap.set({ "o", "x" }, "<unique> ab", "(textobj-sandwich-auto-a)")
-- vim.keymap.set({ "o", "x" }, "<unique> is", "(textobj-sandwich-query-i)")
-- vim.keymap.set({ "o", "x" }, "<unique> as", "(textobj-sandwich-query-a)")
