return {
  { "folke/persistence.nvim", enabled = false },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_session_enabled = false,
    },
    keys = {
      { "<leader>qr", "<CMD>SessionRestore<CR>", mode = { "n" }, desc = "Session Restore" },
      { "<leader>qs", "<CMD>SessionSave<CR>", mode = { "n" }, desc = "Session Save" },
      { "<leader>qd", "<CMD>SessionDelete<CR>", mode = { "n" }, desc = "Session Delete" },
    },
  },
}
