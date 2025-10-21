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

-- vim.api.nvim_create_autocmd("TextChangedT", {
--   callback = function()
--     local is_k9s = (vim.b.term_title == "k9s")
--     local maps_set = vim.b.k9s_maps_set
--
--     if is_k9s and not maps_set then
--       vim.api.nvim_buf_set_keymap(0, "t", "q", "<M-esc>", { silent = true })
--       vim.api.nvim_buf_set_keymap(0, "t", "y", "c", { silent = true })
--       vim.b.k9s_maps_set = true
--     elseif not is_k9s and maps_set then
--       vim.api.nvim_buf_del_keymap(0, "t", "q")
--       vim.api.nvim_buf_del_keymap(0, "t", "y")
--       vim.b.k9s_maps_set = false
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("TextChangedT", {
  callback = function()
    local is_gemini = vim.b.term_title and vim.b.term_title:find("^Gemini")
    local maps_set = vim.b.gemini_maps_set

    if is_gemini and not maps_set then
      vim.api.nvim_buf_set_keymap(0, "t", "<F2>", "<C-x>", { silent = true })
      vim.b.gemini_maps_set = true
    elseif not is_gemini and maps_set then
      vim.api.nvim_buf_del_keymap(0, "t", "<F2>")
      vim.b.gemini_maps_set = false
    end
  end,
})

-- vim.api.nvim_buf_set_keymap(0, "t", "/", "<M-esc>", { silent = true })
-- local buffer_keymaps = vim.api.nvim_get_buf_keymap(0, "n")
-- print(buffer_keymaps)
--
-- -- Iterate through the keymaps to find a specific one
-- local function is_keymap_set(bufnr, mode, lhs)
--   local keymaps = vim.api.nvim_get_buf_keymap(bufnr, mode)
--   for _, keymap in ipairs(keymaps) do
--     if keymap.lhs == lhs then
--       return true, keymap -- Return true and the keymap table if found
--     end
--   end
--   return false
-- end
--
-- -- Example usage:
-- local bufnr = vim.api.nvim_get_current_buf() -- Get the current buffer number
-- local mode = "n"
-- local lhs_to_check = "<leader>f"
--
-- local found, keymap_info = is_keymap_set(bufnr, mode, lhs_to_check)
--
-- if found then
--   print(
--     string.format("Keymap '%s' in mode '%s' is set for buffer %d. RHS: %s", lhs_to_check, mode, bufnr, keymap_info.rhs)
--   )
-- else
--   print(string.format("Keymap '%s' in mode '%s' is NOT set for buffer %d.", lhs_to_check, mode, bufnr))
-- end
