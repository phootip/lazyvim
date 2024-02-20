return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  opts = {
    default_mapping = false,
    -- builtin_marks = { "<", ">" },
    mappings = {
      toggle = "mm",
      -- preview = "<leader>m.",
      preview = "m.",
      next = "m]",
      prev = "m[",
      set_bookmark0 = "m0",
    },
  },
  keys = {
    -- stylua: ignore start
    { 'ml', "<CMD>MarksQFListAll<CR>", silent = true, mode = { "n" }, desc = "Mark list"},
    -- stylua: ignore end
  },
}
