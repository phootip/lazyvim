-- stylua: ignore
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    table.insert(opts.sections.lualine_b, 1, {
      require("nvim-possession").status,
      cond = function()
        return require("nvim-possession").status() ~= nil
      end,
    })
    table.insert(opts.sections.lualine_x, 'filetype')
    table.insert(opts.sections.lualine_x, 'fileformat')
  end,
}
