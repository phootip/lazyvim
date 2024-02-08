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
  { "christoomey/vim-tmux-navigator" },
  { "/echasnovski/mini.surround" , enabled = false },
  {
    "machakann/vim-sandwich",
    event = "VeryLazy",
    keys = {
      -- { "gsa", "<Plug>(sandwich-add)", desc = "Sandwich Add" },
      -- { "gsrb", "<Plug>(sandwich-delete-auto)", desc = "Sandwich Replace Auto" }

			{ 'gsa', '<Plug>(sandwich-add)', silent = true, mode = { 'n', 'x', 'o' }},
			{ 'gsr', '<Plug>(sandwich-replace)', silent = true },
			{ 'gsrb', '<Plug>(sandwich-replace-auto)', silent = true },
			{ 'gsc', '<Plug>(sandwich-replace)', silent = true },
			{ 'gscb', '<Plug>(sandwich-replace-auto)', silent = true },
      { 'gsd', '<Plug>(sandwich-delete)', silent = true },
			{ 'gsdb', '<Plug>(sandwich-delete-auto)', silent = true },
			{ 'ir', '<Plug>(textobj-sandwich-auto-i)', silent = true, mode = { 'x', 'o' }},
			{ 'ab', '<Plug>(textobj-sandwich-auto-a)', silent = true, mode = { 'x', 'o' }},
    }
    -- vim.keymap.set("", "<leader>sa", "<Plug>(sandwich-add)")
    -- vim.keymap.set("", "<leader>sd", "<Plug>(sandwich-delete)")
    -- vim.keymap.set("", "<leader>sdb", "<Plug>(sandwich-delete-auto)")
    -- vim.keymap.set("", "<leader>sr", "<Plug>(sandwich-replace)")
    -- vim.keymap.set("", "<leader>srb", "<Plug>(sandwich-replace-auto)")
    -- vim.keymap.set("", "<leader>sc", "<Plug>(sandwich-replace)")
    -- vim.keymap.set("", "<leader>scb", "<Plug>(sandwich-replace-auto)")
    -- vim.keymap.set({ "o", "x" }, "<unique> ib", "(textobj-sandwich-auto-i)")
    -- vim.keymap.set({ "o", "x" }, "<unique> ab", "(textobj-sandwich-auto-a)")
    -- vim.keymap.set({ "o", "x" }, "<unique> is", "(textobj-sandwich-query-i)")
    -- vim.keymap.set({ "o", "x" }, "<unique> as", "(textobj-sandwich-query-a)")
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
        vim.keymap.set("n", "<leader>El", function()
            possession.list()
        end)
        vim.keymap.set("n", "<leader>En", function()
            possession.new()
        end)
        vim.keymap.set("n", "<leader>Eu", function()
            possession.update()
        end)
        vim.keymap.set("n", "<leader>Ed", function()
            possession.delete()
        end)
    end,
  }
}
