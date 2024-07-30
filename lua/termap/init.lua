local M = {}
local namespace_id
local state = {
  buf_mapping = {},
}

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

M.open = function()
  local buf_a = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(buf_a, 0, -1, true)
  local mem = {}
  for i, line in ipairs(lines) do
    if string.find(line, "function") then
      mem[#mem + 1] = "line: " .. i .. string.rep(" ", (6 - string.len(i))) .. " | " .. line
    end
  end
  vim.cmd("vnew")
  local buf_b = vim.api.nvim_get_current_buf()
  state.buf_mapping[buf_a] = buf_b
  vim.bo.buftype = "nofile"
  vim.bo.buflisted = false
  vim.bo.filetype = "termap"
  vim.api.nvim_buf_set_lines(0, 0, -1, false, mem)
  vim.api.nvim_set_option_value("modifiable", false, { buf = buf_b })
end

M.clear = function()
  local current_buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(current_buf, namespace_id, 0, -1)
end

M.update = function()
  local buf_a = vim.api.nvim_get_current_buf()
  local buf_b = state.buf_mapping[buf_a]

  if not buf_b then
    return
  end

  local current_win = vim.api.nvim_get_current_win()
  local pos = vim.api.nvim_win_get_cursor(current_win)
  local row = pos[1]
  local col = pos[2]

  local lines = vim.api.nvim_buf_get_lines(buf_b, 0, -1, true)
  local target_row = M.find_target(lines, row)

  local current_line = vim.api.nvim_buf_get_lines(buf_b, target_row - 1, target_row, false)[1]
  local end_col = string.len(current_line)

  vim.api.nvim_buf_clear_namespace(buf_b, namespace_id, 0, -1)
  vim.api.nvim_buf_set_extmark(
    buf_b,
    namespace_id,
    target_row - 1,
    0,
    { end_col = end_col, hl_group = "HighlightLine" }
  )
end

M.find_target = function(lines, row)
  local result = 1
  for i, line in ipairs(lines) do
    for cur_row in string.gmatch(line, "line: (%d+)%s*|") do
      if tonumber(cur_row) <= row then
        result = i
      else
        return result
      end
    end
  end
  return result
end

-- stylua: ignore start
vim.keymap.set("n", "<leader>j", function() M.open() end)
vim.keymap.set("n", "<leader>k", function() M.update() end)

return M
