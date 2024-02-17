return {
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     on_colors = function(colors)
  --       colors.border = "#565f89"
  --     end,
  --   },
  -- },
  -- { "ellisonleao/gruvbox.nvim" },
  -- { "sainnhe/gruvbox-material" },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "/rebelot/kanagawa.nvim", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },

  {
    "levouh/tint.nvim",
    -- opts = {
    --   tint_background_colors = true,
    -- },
    config = function()
      vim.keymap.set("n", "<leader>wb", function()
        require("tint").toggle()
      end, { desc = "Toggle background" })
      require("tint").setup({
        tint_background_colors = true,
      })
    end,
  },
}
