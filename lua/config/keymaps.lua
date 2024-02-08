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

-- harpoon
local harpoon = require("harpoon")
-- require("telescope").load_extension("harpoon")
vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():append()
end)
vim.keymap.set("n", "<leader>hn", function()
  harpoon:list():next()
end)
vim.keymap.set("n", "<leader>hp", function()
  harpoon:list():prev()
end)
vim.keymap.set("n", "<leader>he", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)
