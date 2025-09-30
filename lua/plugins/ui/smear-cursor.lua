return {
  {
    "nvim-mini/mini.animate",
    optional = true,
    opts = {
      cursor = { enable = false },
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    config = function()
      local opts = {
        cursor_color = "#d466d8",
      }
      require("smear_cursor").setup(opts)
      -- require("smear_cursor").toggle()
      vim.keymap.set(
        { "n" },
        "<leader>um",
        "<CMD>SmearCursorToggle<CR>",
        { silent = true, desc = "Toggle Smear Cursor" }
      )
    end,
  },
}
