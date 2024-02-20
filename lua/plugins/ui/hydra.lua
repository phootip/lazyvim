return {
  "anuvyklack/hydra.nvim",
  dependencies = {
    "mrjones2014/smart-splits.nvim",
    "sunjon/Shade.nvim",
  },
  config = function()
    local Hydra = require("hydra")
    Hydra({
      name = "Window Operation",
      hint = [[Window Operation]],
      config = {
        color = "red",
        hint = { border = "double" },
      },
      mode = "n",
      body = "<leader>w",
      heads = {
        { "-", require("smart-splits").resize_down, { desc = "Window height up" } },
        { "=", require("smart-splits").resize_up, { desc = "Window height down" } },
        { ".", require("smart-splits").resize_right, { desc = "Decrease window width" } },
        { ",", require("smart-splits").resize_left, { desc = "Increase window width" } },

        { "b", "<cmd>BufferLineMoveNext<cr>", { desc = "Buffer move right" } },
        { "B", "<cmd>BufferLineMovePrev<cr>", { desc = "Buffer move left" } },
        { "t", "<cmd>tabnext<cr>", { desc = "Tab Next" } },
        { "T", "<cmd>tabprevious<cr>", { desc = "Tab previous" } },
        { "r", "<cmd>+tabmove<cr>", { desc = "Tab move right" } },
        { "R", "<cmd>-tabmove<cr>", { desc = "Tab move left" } },
        { "D", "<cmd>-tabclose<cr>", { desc = "Tab close" } },
      },
    })
    vim.keymap.set("n", "<leader>w_", "<C-W>s", { desc = "Split window below", remap = true })
    vim.keymap.set("n", "<leader>bs", "<CMD>w<CR>", { desc = "Save", remap = true })
  end,
}
