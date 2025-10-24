local theme = {
  fill = "TabLineFill",
  head = "TabLine",
  current_tab = { fg = "#223249", bg = "#ff9e3b", style = "italic" },
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}
vim.api.nvim_create_user_command("ToggleTab", function()
  vim.g.tabby_red_mode = not vim.g.tabby_red_mode
end, { desc = "Set current Tabby tab highlight to red" })

local emptyFile = function()
  local path = vim.fn.expand("%:p")
  if path == "" then
    return "empty file"
  else
    return ""
  end
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      { "otavioschwanck/arrow.nvim" },
    },
    opts = function(_, opts)
      table.insert(opts.sections.lualine_b, function()
        return require("arrow.statusline").text_for_statusline_with_icons()
      end)
      table.insert(opts.sections.lualine_x, "filetype")
      table.insert(opts.sections.lualine_x, "fileformat")
      local custom_theme = require("lualine.themes.auto")
      custom_theme.terminal = {
        -- a = { fg = "#1F1F28", bg = "#e03450" },
        a = { fg = "#e03450", bg = "#1F1F28" },
        b = { fg = "#1F1F28", bg = "#e03450" },
        -- b = { fg = "#e03450", bg = "#1F1F28" },
        c = { fg = "#1F1F28", bg = "#b02440" },
      }
      opts.options.theme = custom_theme
      opts.winbar = {
        lualine_b = {
          { require("lazyvim.util").lualine.pretty_path() },
          { emptyFile },
        },
      }
      opts.inactive_winbar = {
        lualine_b = {
          { require("lazyvim.util").lualine.pretty_path() },
          { emptyFile },
        },
      }
      opts.options.disabled_filetypes = {
        winbar = {
          "snacks_dashboard",
          "noice",
          "NvimTree",
          "Avante",
          "AvanteInput",
          "AvanteSelectedFiles",
          "AvanteSelectedCode",
          -- kulala file
          "text",
          "json",
          "html",
          "kulala_verbose_result",
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
            -- local hl = tab.is_current() and theme.current_tab or theme.tab
            -- local hl = tab.is_current() and "@comment.error" or theme.tab
            local current_tab_hl = vim.g.tabby_red_mode and "@comment.error" or theme.current_tab
            local hl = tab.is_current() and current_tab_hl or theme.tab
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
  -- {
  --   "b0o/incline.nvim",
  --   enabled = false,
  --   config = function()
  --     require("incline").setup({
  --       render = function(props)
  --         local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  --         local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
  --         local modified = vim.bo[props.buf].modified and "bold,italic" or "bold"
  --
  --         local function get_git_diff()
  --           local icons = { removed = "", changed = "", added = "" }
  --           icons["changed"] = icons.modified
  --           local signs = vim.b[props.buf].gitsigns_status_dict
  --           local labels = {}
  --           if signs == nil then
  --             return labels
  --           end
  --           for name, icon in pairs(icons) do
  --             if tonumber(signs[name]) and signs[name] > 0 then
  --               table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
  --             end
  --           end
  --           if #labels > 0 then
  --             table.insert(labels, { "┊ " })
  --           end
  --           return labels
  --         end
  --         local function get_diagnostic_label()
  --           local icons = { error = "", warn = "", info = "", hint = "" }
  --           local label = {}
  --
  --           for severity, icon in pairs(icons) do
  --             local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
  --             if n > 0 then
  --               table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
  --             end
  --           end
  --           if #label > 0 then
  --             table.insert(label, { "┊ " })
  --           end
  --           return label
  --         end
  --
  --         local function get_modified()
  --           if vim.bo[props.buf].modified then
  --             return " "
  --           else
  --             return ""
  --           end
  --         end
  --
  --         local buffer = {
  --           { get_diagnostic_label() },
  --           { get_git_diff() },
  --           { get_modified() },
  --           { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" },
  --           { filename .. " ", gui = modified },
  --           { "┊  " .. vim.api.nvim_win_get_number(props.win), group = "DevIconWindows" },
  --         }
  --         return buffer
  --       end,
  --     })
  --   end,
  --   -- Optional: Lazy load Incline
  --   event = "VeryLazy",
  -- },
}
