return {
  "akinsho/bufferline.nvim",
  opts = {
    options = {
      always_show_bufferline = true,
      indicator = {
        style = "underline",
      },
      separator_style = "slant",
      max_name_length = 25,
      -- truncate_names = false,
    },
    highlights = {
      buffer_selected = {
        bold = true,
        italic = true,
        -- bold = false,
        -- italic = false,
      },
    },
  },
}
