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
  -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- { "/rebelot/kanagawa.nvim", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    -- "miversen33/sunglasses.nvim",
    "phootip/sunglasses.nvim",
    enabled = false,
    lazy = false,
    priority = 51,
    opts = {
      excluded_highlights = {
        "WinSeparator",
        { "lualine_.*", glob = true },
        { "Diff*", glob = true },
      },
    },
    keys = {
      {
        "<leader>wb",
        function()
          vim.cmd("SunglassesEnableToggle")
          vim.cmd("SunglassesOff")
        end,
        silent = true,
        mode = { "n" },
        desc = "Session Menu",
      },
    },
  },
}
