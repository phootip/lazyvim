local sortQF = function()
  local l = vim.fn.getqflist()
  table.sort(l, function(a, b)
    return (a.bufnr == b.bufnr and a.lnum < b.lnum) or (a.bufnr < b.bufnr)
  end)
  vim.fn.setqflist(l)
end

return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    default_mapping = false,
    -- builtin_marks = { "<", ">" },
    bookmark_0 = {
      sign = "⚑",
      -- virt_text = "hello world",
      -- -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
      -- -- defaults to false.
      -- annotate = false,
    },
    mappings = {
      -- toggle = "mm",
      -- preview = "<leader>m.",
      preview = "m.",
      next = "m]",
      prev = "m[",
      -- set_bookmark0 = "mm",
      delete_bookmark0 = "mc",
    },
  },
  keys = {
    -- stylua: ignore start
    -- { 'ml', "<CMD>MarksQFListAll<CR>", silent = true, mode = { "n" }, desc = "Mark list"},
    { 'mm', "<Plug>(Marks-toggle-bookmark0)", silent = true, mode = { "n" }, desc = "Mark list"},
    -- 
    { 'ml', function() vim.cmd("BookmarksQFListAll"); sortQF() end, silent = true, mode = { "n" }, desc = "Mark list"},
    -- { 'ml', function() vim.cmd("BookmarksQFListAll") end, silent = true, mode = { "n" }, desc = "Mark list"},
    -- { 'ms', function() sortQF() end, silent = true, mode = { "n" }, desc = "Mark list"},
    -- { 'mx', function() sortQFLine() end, silent = true, mode = { "n" }, desc = "Mark list"},
    -- stylua: ignore end
  },
}
