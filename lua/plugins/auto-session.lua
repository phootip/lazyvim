return {
  { "folke/persistence.nvim", enabled = false },
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        -- log_level = "error",
      })
    end,
  },
}
