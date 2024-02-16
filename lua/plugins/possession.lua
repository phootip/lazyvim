-- stylua: ignore
-- if true then return {} end
-- stylua: ignore
return {
  { "folke/persistence.nvim", enabled = false },
  {
    "gennaro-tedesco/nvim-possession",
    lazy = false,
    dependencies = {
        {"ibhagwan/fzf-lua"},
        {"phootip/scope.nvim"},
    },
    keys = {
			{ '<leader>qe', function() require("nvim-possession").list() end, silent = true, mode = { "n" }, desc = "Session Menu"},
			{ '<leader>qn', function() require("nvim-possession").new() end, silent = true, mode = { 'n' }, desc = "New Session"},
			{ '<leader>qu', function() require("nvim-possession").update(); vim.cmd([[ScopeLoadState]])  end, silent = true, mode = { 'n' }, desc = "Update Session"},
    },
    -- config = true,
    config = function()
        require("nvim-possession").setup({
            autoload = true,
            autosave = true,
            autoswitch = {
                enable = true,
            },
            save_hook = function()
                vim.cmd([[ScopeSaveState]]) -- Scope.nvim saving
                vim.cmd([[ScopeExpand]])
            end,
            post_hook = function()
                vim.cmd([[ScopeLoadState]]) -- Scope.nvim loading
                vim.opt.ch = 1
            end,
        })
    end,
  }
}
