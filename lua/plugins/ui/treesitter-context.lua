return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function()
    vim.cmd("hi TreesitterContextBottom gui=underline guisp=Grey")
    vim.cmd("hi link TreesitterContext LspReferenceText")
  end,
}
