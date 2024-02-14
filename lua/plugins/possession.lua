-- stylua: ignore
return {
  { "folke/persistence.nvim", enabled = false },
  {
    "gennaro-tedesco/nvim-possession",
    lazy = false,
    dependencies = {
        {"ibhagwan/fzf-lua"},
    },
    keys = {
			{ '<leader>qe', function() require("nvim-possession").list() end, silent = true, mode = { "n" }, desc = "Session Menu"},
			{ '<leader>qn', function() require("nvim-possession").new() end, silent = true, mode = { 'n' }, desc = "New Session"},
			{ '<leader>qu', function() require("nvim-possession").update() end, silent = true, mode = { 'n' }, desc = "Update Session"},
    },
    config = function()
        require("nvim-possession").setup({
            autoload = true,
        })
    end,
  }
}
