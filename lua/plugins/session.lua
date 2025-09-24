return {
  { "folke/persistence.nvim", enabled = false },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_session_enabled = false,
    },
    keys = {
      { "<leader>qr", "<CMD>AutoSession restore<CR>", mode = { "n" }, desc = "Session Restore" },
      { "<leader>qs", "<CMD>AutoSession save<CR>", mode = { "n" }, desc = "Session Save" },
      { "<leader>qd", "<CMD>AutoSession delete<CR>", mode = { "n" }, desc = "Session Delete" },
    },
  },
}
