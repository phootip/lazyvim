local theme = {
  fill = "TabLineFill",
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = "TabLine",
  -- current_tab = 'TabLineSel',
  -- current_tab = { fg = "#F8FBF6", bg = "#896a98", style = "italic" },
  current_tab = { fg = "#223249", bg = "#ff9e3b", style = "italic" },
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "filetype")
      table.insert(opts.sections.lualine_x, "fileformat")
      opts.winbar = {
        lualine_b = {
          -- {
          --   "filename",
          --   path = 4,
          --   symbols = {
          --     modified = "", -- Text to show when the file is modified.
          --   },
          -- },
          {
            require("lazyvim.util").lualine.pretty_path(),
          },
        },
        lualine_y = {
          {
            function()
              return vim.fn.getcwd()
            end,
          },
        },
      }
      opts.inactive_winbar = {
        lualine_b = {
          { require("lazyvim.util").lualine.pretty_path() },
        },
      }
    end,
  },
  {
    "nanozuki/tabby.nvim",
    event = "VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("tabby.tabline").set(function(line)
        return {
          {
            { "  ", hl = theme.head },
            line.sep("", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "",
              tab.number(),
              tab.name(),
              -- tab.close_btn(''), -- show a close button
              line.sep("", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          {
            line.sep("", theme.tail, theme.fill),
            { "  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
  },
  {
    "b0o/incline.nvim",
    enabled = false,
    config = function()
      require("incline").setup({
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"

          local function get_git_diff()
            local icons = { removed = "", changed = "", added = "" }
            icons["changed"] = icons.modified
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { "┊ " })
            end
            return labels
          end
          local function get_diagnostic_label()
            local icons = { error = "", warn = "", info = "", hint = "" }
            local label = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
              end
            end
            if #label > 0 then
              table.insert(label, { "┊ " })
            end
            return label
          end

          local function get_modified()
            if vim.bo[props.buf].modified then
              return " "
            else
              return ""
            end
          end

          local buffer = {
            { get_diagnostic_label() },
            { get_git_diff() },
            { get_modified() },
            { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
            { filename .. " ", gui = modified },
            { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
          }
          return buffer
        end,
      })
    end,
    -- Optional: Lazy load Incline
    event = "VeryLazy",
  },
}
