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
    },
  },
  {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    keys = {
      { "<leader>go", "<CMD>Neogit kind=auto<CR>", silent = true, mode = { "n" }, desc = "Neogit" },
    },
  },
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
