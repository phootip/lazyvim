-- stylua: ignore
return {
  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   -- keys = {
  --   --   { "<leader>he", function() require("harpoon").ui:toggle_quick_menu(harpoon:list()) end, silent = true, mode = { "n" }, desc = "Session Menu"},
  --   --   { "<leader>he", function() require("harpoon"):list():append() end, silent = true, mode = { "n" }, desc = "Session Menu"},
  --   --   },
  --   config = function()
  --     local harpoon = require("harpoon")
  --     ---@diagnostic disable-next-line: missing-parameter
  --     harpoon:setup()
  --     local function map(lhs, rhs, opts)
  --       vim.keymap.set("", lhs, rhs, opts or {})
  --     end
  --     map("<leader>hh", function() harpoon:list():add() end)
  --     map("<leader>he", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
  --     -- map("<M-h>", function() harpoon:list():select(1) end)
  --     -- map("<M-l>", function() harpoon:list():select(4) end)
  --   end
  -- },
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "echasnovski/mini.icons" },
    },
    event = "VeryLazy",
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
    },
    keys = {
      { "<M-h>", function() require("arrow.persist").go_to(1) end },
      { "<M-j>", function() require("arrow.persist").go_to(2) end },
      { "<M-k>", function() require("arrow.persist").go_to(3) end },
      { "<M-l>", function() require("arrow.persist").go_to(4) end },
    }
  }
}
