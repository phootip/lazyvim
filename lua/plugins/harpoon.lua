-- stylua: ignore
return {
  {
    "otavioschwanck/arrow.nvim",
    dependencies = {
      { "nvim-mini/mini.icons" },
    },
    event = "VeryLazy",
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = 'm', -- Per Buffer Mappings
    },
    keys = {
      -- { "<M-h>", function() require("arrow.persist").go_to(1) end },
      -- { "<M-j>", function() require("arrow.persist").go_to(2) end },
      -- { "<M-k>", function() require("arrow.persist").go_to(3) end },
      -- { "<M-l>", function() require("arrow.persist").go_to(4) end },
    }
  }
}
