return {
  {
    "folke/tokyonight.nvim",
    opts = {
      on_colors = function(colors)
        colors.border = "#565f89"
      end,
      on_highlights = function(hl, _)
        hl.DiffAdd = {
          bg = "#2d4235",
        }
        hl.DiffText = {
          bg = "#6e6746",
        }
        hl.CursorLine = {
          bg = "#392747",
        }
        hl.CursorColumn = {
          bg = "#392747",
        }
      end,
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {
      highlight = {
        search = "DiffAdd",
      },
    },
  },
  -- { "LazyVim/LazyVim", opts = { colorscheme = "tokyonight" } },
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      transparent = true,
      -- dimInactive = true,
      -- background = {
      --   dark = "dragon",
      -- },
      overrides = function(colors)
        return {
          -- Visual = { bg = "#304666" },
          Visual = { bg = "#415d87" },
        }
      end,
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "kanagawa" } },
  -- -- { "LazyVim/LazyVim", opts = { colorscheme = "kanagawa-dragon" } },
}
