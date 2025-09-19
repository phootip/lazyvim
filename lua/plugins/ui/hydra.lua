return {
  "anuvyklack/hydra.nvim",
  dependencies = {
    "mrjones2014/smart-splits.nvim",
    "sunjon/Shade.nvim",
  },
  config = function()
    local Hydra = require("hydra")
    vim.hydra = {}
    vim.hydra.config = {
      color = "red",
      hint = { border = "double" },
    }
    Hydra({
      name = "Window Operation",
      hint = [[Window Operation]],
      config = vim.hydra.config,
      mode = "n",
      body = "<leader>w",
      heads = {
        { "j", require("smart-splits").resize_down, { desc = "Window height up" } },
        { "k", require("smart-splits").resize_up, { desc = "Window height down" } },
        { "l", require("smart-splits").resize_right, { desc = "Decrease window width" } },
        { "h", require("smart-splits").resize_left, { desc = "Increase window width" } },

        { "b", "<cmd>BufferLineMoveNext<cr>", { desc = "Buffer move right" } },
        { "B", "<cmd>BufferLineMovePrev<cr>", { desc = "Buffer move left" } },
        { "t", "<cmd>tabnext<cr>", { desc = "Tab Next" } },
        { "T", "<cmd>tabprevious<cr>", { desc = "Tab previous" } },
        { "r", "<cmd>+tabmove<cr>", { desc = "Tab move right" } },
        { "R", "<cmd>-tabmove<cr>", { desc = "Tab move left" } },
        { "D", "<cmd>-tabclose<cr>", { desc = "Tab close" } },
      },
    })
    Hydra({
      name = "Fold Operation",
      hint = [[Fold Operation]],
      config = vim.hydra.config,
      mode = "n",
      body = "z",
      heads = {
        { "j", "zj", { desc = "Next Fold" } },
        { "k", "zk", { desc = "Previous Fold" } },
        {
          "<Enter>",
          function()
            if vim.o.buftype == "quickfix" then
              return "<Enter>"
            else
              local line = vim.fn.line(".")
              if vim.fn.foldclosed(line) ~= -1 then
                return "zo"
              else
                return "zjzo"
              end
            end
          end,
          { desc = "Fold Open", expr = true, replace_keycodes = true },
        },
        { "<BS>", "zc", { desc = "Fold Close" } },
      },
    })
    vim.keymap.set("n", "<leader>w_", "<C-W>s", { desc = "Split window below", remap = true })
    vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window side", remap = true })
    vim.keymap.set("n", "<leader>bs", "<CMD>w<CR>", { desc = "Save", remap = true })
  end,
}
