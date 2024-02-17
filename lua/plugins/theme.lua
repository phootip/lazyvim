return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
    opts = {
      on_colors = function(colors)
        colors.border = "#565f89"
      end,
    },
  },
  {
    "sontungexpt/witch",
    priority = 1000,
    lazy = false,
    config = function(_, opts)
      require("witch").setup(opts)
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "witch",
    },
  },
  -- {
  --   "sunjon/Shade.nvim",
  --   config = function()
  --     require("shade").setup({
  --       overlay_opacity = 45,
  --       opacity_step = 5,
  --     })
  --   end,
  -- },
}
