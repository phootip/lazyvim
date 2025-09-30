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