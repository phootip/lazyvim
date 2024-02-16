-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("InsertEnter", { command = "set norelativenumber" })
vim.api.nvim_create_autocmd("InsertLeave", { command = "set relativenumber" })
vim.api.nvim_create_autocmd("TabEnter", { command = "set cmdheight=1" })
-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = vim.api.nvim_create_augroup("persistence", { clear = true }),
--   callback = function()
--     require("persistence").load()
--   end,
-- })
-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = vim.api.nvim_create_augroup("restore_session", { clear = true }),
--   callback = function()
--     if vim.fn.getcwd() ~= vim.env.HOME then
--       require("persistence").load()
--     end
--   end,
--   nested = true,
-- })
