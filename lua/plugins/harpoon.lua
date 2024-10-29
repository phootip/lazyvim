-- stylua: ignore
return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    -- keys = {
    --   { "<leader>he", function() require("harpoon").ui:toggle_quick_menu(harpoon:list()) end, silent = true, mode = { "n" }, desc = "Session Menu"},
    --   { "<leader>he", function() require("harpoon"):list():append() end, silent = true, mode = { "n" }, desc = "Session Menu"},
    --   },
    config = function()
      local harpoon = require("harpoon")
      ---@diagnostic disable-next-line: missing-parameter
      harpoon:setup()
      local function map(lhs, rhs, opts)
        vim.keymap.set("", lhs, rhs, opts or {})
      end
      map("<leader>hh", function() harpoon:list():add() end)
      map("<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      map("<M-h>", function() harpoon:list():select(1) end)
      map("<M-l>", function() harpoon:list():select(4) end)
    end
  },
}
