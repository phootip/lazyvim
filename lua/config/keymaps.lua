-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("x", "p", "P")
vim.keymap.set("x", "P", "p")
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_X')
vim.keymap.set("n", "dx", '""dd')
vim.keymap.set({ "n" }, "vil", "^vg_")
vim.keymap.set({ "n" }, "val", "0v$h")

vim.keymap.set({ "n", "x", "i" }, "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set({ "n", "x", "i" }, "<C-j>", "<CMD>TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set({ "n", "x", "i" }, "<C-k>", "<CMD>TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set({ "n", "x", "i" }, "<C-l>", "<CMD>TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set({ "n", "x", "i" }, "<M-j>", "<cmd>tabp<cr>")
vim.keymap.set({ "n", "x", "i" }, "<M-k>", "<cmd>tabn<cr>")

vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "g_")
-- vim.keymap.set("n", "K", "<cmd>BufferLineCycleNext<cr>")
-- vim.keymap.set("n", "J", "<cmd>BufferLineCyclePrev<cr>")
vim.keymap.set("n", "K", "<cmd>tabn<cr>")
vim.keymap.set("n", "J", "<cmd>tabp<cr>")
vim.keymap.set("n", "]<Tab>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[<Tab>", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>")
vim.keymap.set("n", "<leader>tr", "<cmd>TabRename <cr>")

vim.keymap.set("n", "<leader>.", "<cmd>@:<cr>")

-- terminal
vim.api.nvim_del_keymap("t", "<Esc><Esc>")
vim.keymap.set({ "t" }, "<esc>", "<c-\\><c-n>")
vim.keymap.set({ "n" }, "q", function()
  if vim.bo.buftype == "terminal" then
    vim.api.nvim_feedkeys("i", "n", true)
  else
    vim.api.nvim_feedkeys("q", "n", true)
  end
end)

vim.keymap.set("", "<leader>ct", function()
  vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 1 or 0
end)
-- vim.keymap.del("n", "<leader>w-")
