local disabled_filetypes = { "AvanteInput", "Avante", "*.kulala_ui" }

local function is_disabled(filetype, patterns)
  for _, pattern in ipairs(patterns) do
    local regex = vim.fn.glob2regpat(pattern)
    if vim.regex(regex):match_str(filetype) then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    if not is_disabled(vim.bo.filetype, disabled_filetypes) then
      vim.wo.relativenumber = false
    end
  end,
})
vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    if not is_disabled(vim.bo.filetype, disabled_filetypes) then
      vim.wo.relativenumber = true
    end
  end,
})
-- vim.api.nvim_create_autocmd("TabEnter", { command = "set cmdheight=1" })
vim.api.nvim_create_autocmd("TermOpen", { command = "set signcolumn=yes" })
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.wo.sidescrolloff = 0
    else
      vim.wo.sidescrolloff = 8
    end
  end,
})

vim.api.nvim_create_autocmd("TextChangedT", {
  callback = function()
    local term_title = vim.b.term_title -- May need to be set by the program itself
    if term_title == "k9s" then
      vim.api.nvim_buf_set_keymap(0, "t", "q", "<M-esc>", { silent = true })
    else
      pcall(vim.api.nvim_buf_del_keymap, 0, "t", "q")
    end
  end,
})
