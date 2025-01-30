return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = {
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
    },
  },
  keys = {
    { "<C-a>", "<CMD>CodeCompanionActions<CR>", silent = true, mode = { "n" }, desc = "CodeCompanionActions" },
  },
}
