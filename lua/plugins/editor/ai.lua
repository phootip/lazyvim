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
        keymaps = {
          close = {
            modes = { n = "<C-F14>", i = "<C-F14>" },
          },
        },
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
