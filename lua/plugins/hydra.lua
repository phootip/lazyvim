return {
  "anuvyklack/hydra.nvim",
  dependencies = {
    "mrjones2014/smart-splits.nvim",
    "sunjon/Shade.nvim",
  },
  config = function()
    local Hydra = require("hydra")
    Hydra({
      -- name = "Resize Window",
      hint = [[Modify Window]],
      config = { color = "pink", hint = { border = "double" } },
      mode = "n",
      body = "<leader>w",
      heads = {
        { "-", require("smart-splits").resize_down, { desc = "Window height up" } },
        { "=", require("smart-splits").resize_up, { desc = "Window height down" } },
        { ".", require("smart-splits").resize_right, { desc = "Decrease window width" } },
        { ",", require("smart-splits").resize_left, { desc = "Increase window width" } },

        -- { "<Up>", require("shade").brightness_up, { desc = "Increase window width" } },
        -- { "<Down>", require("shade").brightness_down, { desc = "Increase window width" } },
        -- { "b", require("shade").toggle, { desc = "Increase window width" } },
      },
    })
    vim.keymap.set("n", "<leader>w_", "<C-W>s", { desc = "Split window below", remap = true })
  end,
}
