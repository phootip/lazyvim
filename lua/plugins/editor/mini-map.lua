return {
  {
    "nvim-mini/mini.map",
    lazy = true,
    version = false,
    opts = function()
      local MiniMap = require("mini.map")
      return {
        symbols = {
          encode = MiniMap.gen_encode_symbols.dot("4x2"),
          -- encode = MiniMap.gen_encode_symbols.shade("2x1"),
        },
      }
    end,
    keys = {
    -- stylua: ignore start
      { "<leader>mt", function() require("mini.map").toggle() end,
        desc = "toggle MiniMap"},
      { "<leader>mr", function() require("mini.map").refresh() end,
        desc = "toggle MiniMap"},
      { "<leader>mf", function() require("mini.map").toggle_focus() end,
        desc = "toggle MiniMap"},
    },
  },
}
