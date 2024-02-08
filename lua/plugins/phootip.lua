-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    "christoomey/vim-tmux-navigator",
  },
  { "ThePrimeagen/harpoon",          branch = "harpoon2" },
  {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
        "ibhagwan/fzf-lua",
    },
    config = true,
    init = function()
        local possession = require("nvim-possession")
        vim.keymap.set("n", "<leader>ssl", function()
            possession.list()
        end)
        vim.keymap.set("n", "<leader>ssn", function()
            possession.new()
        end)
        vim.keymap.set("n", "<leader>ssu", function()
            possession.update()
        end)
        vim.keymap.set("n", "<leader>ssd", function()
            possession.delete()
        end)
    end,
  }
}
