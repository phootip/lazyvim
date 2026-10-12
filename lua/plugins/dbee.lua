return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install()
    end,
    config = function()
      require("dbee").setup({
        drawer = {
          default_width = 40,
        },
      })
    end,
    keys = {
      { "<leader>D", function() require("dbee").toggle() end, desc = "Toggle DB Explorer" },
    },
  },
}
