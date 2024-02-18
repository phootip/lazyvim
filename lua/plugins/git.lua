return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gb", "<CMD>Git blame<CR>", silent = true, mode = { "n" }, desc = "Git blame" },
      {
        "<leader>gfd",
        "yiw<CMD>TmuxNavigateUp<CR>:Gvdiffsplit <C-R>0<CR>",
        silent = true,
        mode = { "n" },
        desc = "Git file diff",
      },
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
    keys = {
      { "<leader>gfh", "<CMD>DiffviewFileHistory %<CR>", silent = true, mode = { "n" }, desc = "Git file history" },
      { "<leader>gfH", "<CMD>DiffviewFileHistory<CR>", silent = true, mode = { "n" }, desc = "Git history" },
      { "<leader>go", "<CMD>DiffviewOpen<CR>", silent = true, mode = { "n" }, desc = "Git open diff" },
    },
    opts = {
      enhanced_diff_hl = true,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
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
