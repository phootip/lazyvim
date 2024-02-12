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
        vim.keymap.set("n", lhs, rhs, opts or {})
      end
      map("<leader>ha", function() harpoon:list():append() end)
      map("<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      map("gh", function() harpoon:list():select(1) end)
      map("gj", function() harpoon:list():select(2) end)
      map("gk", function() harpoon:list():select(3) end)
      map("gl", function() harpoon:list():select(4) end)
    end
  },
}
