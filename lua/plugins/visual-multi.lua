return {
  -- { "mg979/vim-visual-multi" },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      -- stylua: ignore start
      vim.keymap.set({"n", "v"}, "<c-n>", function() mc.addCursor("*"); vim.cmd("noh") end)
      vim.keymap.set({"n", "v"}, "<leader>mc", mc.clearCursors)
      -- Rotate the main cursor.
      vim.keymap.set({"n", "v"}, "<left>", mc.nextCursor)
      vim.keymap.set({"n", "v"}, "<right>", mc.prevCursor)
      -- Customize how cursors look.
      -- vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
      -- vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      -- vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      -- vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    end,
  },
}
