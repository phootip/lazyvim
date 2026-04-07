return {
  -- { "mg979/vim-visual-multi" },
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")
      mc.setup()
      -- stylua: ignore start
      vim.keymap.set({"n", "v"}, "<c-n>", function()
        vim.fn.setreg('"', vim.fn.getreg('+'))
        mc.matchAddCursor(1)
      end)
      vim.keymap.set({"n", "v"}, "<leader>mc", mc.clearCursors)
      -- Rotate the main cursor.
      -- vim.keymap.set({ "n", "v" }, "<c-q>", mc.toggleCursor)
      -- Add cursor
      vim.keymap.set({"n", "v"}, "<leader><up>", function() mc.lineAddCursor(-1) end)
      vim.keymap.set({"n", "v"}, "<leader><down>", function() mc.lineAddCursor(1) end)
      vim.keymap.set({"n", "v"}, "<s-up>", function() mc.lineAddCursor(-1) end)
      vim.keymap.set({"n", "v"}, "<s-down>", function() mc.lineAddCursor(1) end)

      mc.addKeymapLayer(function(layerSet)

          -- Select a different cursor as the main one.
          layerSet({"n", "x"}, "<left>", mc.prevCursor)
          layerSet({"n", "x"}, "<right>", mc.nextCursor)

          -- Delete the main cursor.
          -- layerSet({"n", "x"}, "<c-m>", mc.deleteCursor)
          layerSet({"n", "x"}, "<c-j>", function() mc.matchAddCursor(1) end)
          layerSet({"n", "x"}, "<c-k>", mc.deleteCursor)
          layerSet({"n", "x"}, "<c-l>", function() mc.matchSkipCursor(1) end)
          layerSet({"n", "x"}, "<c-h>", mc.deleteCursor)
          -- paste with system clipboard
          layerSet({"n", "x"}, "p", '"+P')
      end)

      -- Customize how cursors look.
      -- vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
      -- vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
      -- vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      -- vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    end,
  },
}
