-- stylua: ignore
if true then return {} end
-- stylua: ignore
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_b, 1, {
      -- require("nvim-possession").status,
      -- cond = function()
      --   return require("nvim-possession").status() ~= nil
      -- end,
      require('auto-session.lib').current_session_name
    })
  end,
}
