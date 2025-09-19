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

-- vim.api.nvim_create_autocmd("TermOpen", {
--   command = "setlocal signcolumn=auto",
-- })
-- local ns = vim.api.nvim_create_namespace("my.terminal.prompt")
-- vim.api.nvim_create_autocmd("TermRequest", {
--   callback = function(args)
--     -- if string.match(args.data.sequence, "^\027]133;A") then
--     --   local lnum = args.data.cursor[1]
--     --   vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
--     --     sign_text = "▶",
--     --     sign_hl_group = "SpecialChar",
--     --   })
--     -- end
--     if string.match(args.data.sequence, "^\027]133;A") then
--       local lnum = args.data.cursor[1]
--       vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
--         sign_text = "▶",
--         sign_hl_group = "SpecialChar",
--       })
--     end
--   end,
-- })
