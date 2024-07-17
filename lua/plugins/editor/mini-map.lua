return {
  {
    "echasnovski/mini.map",
    lazy = true,
    version = false,
    -- opts = true,
    keys = {
      {
        "<leader>m",
        function()
          require("mini.map").toggle()
        end,
        desc = "toggle MiniMap",
      }
    },
  },
}
