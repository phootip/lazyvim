return {
  { "/echasnovski/mini.surround", enabled = false },
  {
    "machakann/vim-sandwich",
    event = "VeryLazy",
    keys = {
      -- { "gsa", "<Plug>(sandwich-add)", desc = "Sandwich Add" },
      -- { "gsrb", "<Plug>(sandwich-delete-auto)", desc = "Sandwich Replace Auto" }

      { "gsa", "<Plug>(sandwich-add)", silent = true, mode = { "n", "x", "o" } },
      { "gsr", "<Plug>(sandwich-replace)", silent = true },
      { "gsrr", "<Plug>(sandwich-replace-auto)", silent = true },
      { "gsc", "<Plug>(sandwich-replace)", silent = true },
      { "gscc", "<Plug>(sandwich-replace-auto)", silent = true },
      { "gsd", "<Plug>(sandwich-delete)", silent = true },
      { "gsdo", "<Plug>(sandwich-delete-auto)", silent = true },
      { "ir", "<Plug>(textobj-sandwich-auto-i)", silent = true, mode = { "x", "o" } },
      { "ab", "<Plug>(textobj-sandwich-auto-a)", silent = true, mode = { "x", "o" } },
    },
  },
}
