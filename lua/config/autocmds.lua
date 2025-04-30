-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber" })
-- vim.api.nvim_create_autocmd("TabEnter", { command = "set cmdheight=1" })
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.wo.sidescrolloff = 0
    else
      vim.wo.sidescrolloff = 8
    end
  end,
})
