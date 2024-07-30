local M = {}
local namespace_id
local state = {
  buf_mapping = {},
  augroup_id = nil,
}

function M.setup()
  state.augroup_id = vim.api.nvim_create_augroup("termap", {
    clear = false,
  })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = "termap",
    pattern = "*",
    callback = M.set_hl,
  })
  M.set_hl()
end

M.set_hl = function()
  vim.api.nvim_set_hl(0, "TermapCurrentLine", { link = "@comment.warning" })
  -- vim.api.nvim_set_hl(0, "TermapCurrentLine", { link = "DiffAdd" })
  namespace_id = vim.api.nvim_create_namespace("termap_ns")
end

M.open = function()
  local buf_a = vim.api.nvim_get_current_buf()
  vim.cmd("60vnew")
  local buf_b = vim.api.nvim_get_current_buf()
  state.buf_mapping[buf_a] = buf_b
  vim.bo.buftype = "nofile"
  vim.bo.buflisted = false
  vim.bo.filetype = "termap"
  -- vim.api.nvim_set_option_value("modifiable", false, { buf = buf_b })
  vim.cmd("wincmd h")
  M.refresh()
  vim.api.nvim_create_autocmd("TextChanged", {
    group = "termap",
    buffer = buf_a,
    callback = M.refresh,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = "termap",
    buffer = buf_a,
    callback = M.update,
  })
end

M.close = function()
  local buf_a = vim.api.nvim_get_current_buf()
  local wins = vim.fn.win_findbuf(state.buf_mapping[buf_a])
  for _, win_id in pairs(wins) do
    vim.api.nvim_win_close(win_id, true)
  end
  state.buf_mapping[buf_a] = nil
  vim.api.nvim_clear_autocmds({
    group = "termap",
    buffer = buf_a,
  })
end

M.toggle = function()
  local buf_a = vim.api.nvim_get_current_buf()
  if state.buf_mapping[buf_a] then
    M.close()
  else
    M.open()
  end
end

M.refresh = function()
  M.search()
  M.update()
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
    { end_col = end_col, hl_group = "TermapCurrentLine" }
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

M.search = function()
  local buf_a = vim.api.nvim_get_current_buf()
  local buf_b = state.buf_mapping[buf_a]
  local lines = vim.api.nvim_buf_get_lines(buf_a, 0, -1, true)
  local mem = {}
  for i, line in ipairs(lines) do
    if string.find(line, "❯") then
      -- if string.find(line, "function") then
      mem[#mem + 1] = "line: " .. i .. string.rep(" ", (6 - string.len(i))) .. " | " .. line
    end
  end
  vim.api.nvim_buf_set_lines(buf_b, 0, -1, false, mem)
end

-- stylua: ignore start
vim.keymap.set("n", "<leader>j", function() M.toggle() end)
vim.keymap.set("n", "<leader>k", function()
  local cmds = vim.api.nvim_get_autocmds({group = "termap"})
  print(dump(cmds))
end)

return M
