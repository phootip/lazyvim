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
  { "ThePrimeagen/harpoon",          branch = "harpoon2" },
  {
    "gennaro-tedesco/nvim-possession",
    dependencies = {
        "ibhagwan/fzf-lua",
    },
    config = true,
    keys = {
			{ '<leader>qe', function() require("nvim-possession").list() end, silent = true, mode = { "n" }, desc = "Session Menu"},
			{ '<leader>qn', function() require("nvim-possession").new() end, silent = true, mode = { 'n' }, desc = "New Session"},
    },
  }
}
