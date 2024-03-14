return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gb", "<CMD>Git blame<CR>", silent = true, mode = { "n" }, desc = "Git blame" },
    },
  },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>gfh", ":DiffviewFileHistory<CR>", silent = true, mode = { "x" }, desc = "Git line history" },
      { "<leader>gfh", "<CMD>DiffviewFileHistory %<CR>", silent = true, mode = { "n" }, desc = "Git file history" },
      { "<leader>gfH", "<CMD>DiffviewFileHistory<CR>", silent = true, mode = { "n" }, desc = "Git history" },
      { "<leader>gfd", "<CMD>DiffviewOpen<CR>", silent = true, mode = { "n" }, desc = "Git diff" },
      { "<leader>gd", "<CMD>DiffviewOpen<CR>", silent = true, mode = { "n" }, desc = "Git diff" },
    },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        file_panel = {
          listing_style = "list",
        },
        keymaps = {
          view = {
            { { "n" }, "q", "<CMD>DiffviewClose<CR>", { silent = true } },
          },
          -- stylua: ignore start
          file_panel = {
            -- { "n", "a", actions.stage_all, { desc = "Stage all entries" } },
            { "n", "q", function() vim.cmd("DiffviewClose") end, { desc = "Quit" } },
          },
          file_history_panel = {
            { "n", "q", function() vim.cmd("DiffviewClose") end, { desc = "Quit" } },
          },
          -- stylua: ignore end
        },
      })
    end,
  },
  -- {
  --   "NeogitOrg/neogit",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "sindrets/diffview.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  --   opts = {
  --     graph_style = "unicode",
  --   },
  --   -- config = true,
  --   keys = {
  --     { "<leader>go", "<CMD>Neogit<CR>", silent = true, mode = { "n" }, desc = "Neogit" },
  --   },
  -- },
  -- {
  --   "lewis6991/gitsigns.nvim",
  --   -- opts = {
  --   --   preview_config = {},
  --   -- },
  --   keys = {
  --     { "<leader>gp", require("gitsigns").preview_hunk, silent = true, mode = { "n" }, desc = "Git open diff" },
  --   },
  -- },
  -- {
  --   "tanvirtin/vgit.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     settings = {
  --       scene = {
  --         diff_preference = "split",
  --         keymaps = {
  --           quit = "q",
  --         },
  --       },
  --     },
  --   },
  --   keys = {
  --     {
  --       "<leader>gp",
  --       "<CMD>VGit buffer_hunk_preview<CR>",
  --       silent = true,
  --       mode = { "n" },
  --       desc = "Git file history",
  --     },
  --   },
  -- },
}
