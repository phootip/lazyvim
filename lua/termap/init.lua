local M = {}
local namespace_id

function M.setup()
  M.set_hl()
end

M.set_hl = function()
  vim.api.nvim_set_hl(0, "HighlightLine", { link = "@comment.warning" })
  namespace_id = vim.api.nvim_create_namespace("termap_ns")
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = M.set_hl,
})

function M.highlight()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  local pos = vim.api.nvim_win_get_cursor(current_win)
  print(dump(pos))
  local row = pos[1] - 1
  local col = pos[2]
  local current_line = vim.api.nvim_buf_get_lines(current_buf, row, row + 1, false)[1]
  local end_col = string.len(current_line)

  vim.api.nvim_buf_set_extmark(
    current_buf,
    namespace_id,
    row,
    0,
    { end_row = row, end_col = end_col, hl_group = "HighlightLine" }
  )
end

M.open = function()
  print("Start")
  local buf = vim.api.nvim_get_current_buf()
  local texts = vim.api.nvim_buf_get_lines(buf, 0, -1, true)
  local mem = {}
  for i, text in ipairs(texts) do
    if string.find(text, "function") then
      mem[#mem + 1] = i .. ":" .. text
    end
  end
  vim.cmd("vnew")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, mem)
end

M.clear = function()
  local current_buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(current_buf, namespace_id, 0, -1)
end

vim.keymap.set("n", "<leader>j", function()
  M.open()
end)

return M
