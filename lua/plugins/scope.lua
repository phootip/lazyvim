return {
  {
    "tiagovla/scope.nvim",
    init = function()
      require("scope").setup({})
      require("telescope").load_extension("scope")
    end,
    keys = {
      { "<leader>fB", "<cmd>Telescope scope buffers<cr>", desc = "All Buffers" },
    },
  },
}
