return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.border = "#565f89"
      end,
    },
  },
  {
    "sunjon/Shade.nvim",
    config = function()
      require("shade").setup({
        opts = {
          overlay_opacity = 50,
          opacity_step = 2,
        },
      })
    end,
  },
}
