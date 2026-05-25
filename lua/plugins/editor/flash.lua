return {
  "folke/flash.nvim",
  config = function(_, opts)
    opts.search = {
      -- mode = "fuzzy",
    }
    require("flash").setup(opts)
  end,
}
