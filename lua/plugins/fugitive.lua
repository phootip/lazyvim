return {
  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gb", "<CMD>Git blame<CR>", silent = true, mode = { "n" }, desc = "Git blame" },
      { "<leader>gfh", "<CMD>0Gclog<CR>", silent = true, mode = { "n" }, desc = "Git file history" },
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
}
