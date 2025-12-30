return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layouts = {
        dropdown = {
          layout = {
            backdrop = false,
            row = 1,
            min_width = 80,
            width = 0.9,
            height = 0.9,
            -- border = "none",
            box = "vertical",
            { win = "preview", title = "{preview}", height = 0.6, border = "rounded" },
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
      },
      layout = {
        preset = "dropdown",
      },
      sources = {
        explorer = {
          hidden = true,
          win = {
            list = {
              keys = {
                ["Y"] = "copy_path",
              },
            },
          },
          actions = {
            copy_path = function(_, item)
              local modify = vim.fn.fnamemodify
              local filepath = item.file
              local filename = modify(filepath, ":t")
              local values = {
                filepath,
                modify(filepath, ":."),
                modify(filepath, ":.") .. "/*",
                modify(filepath, ":~"),
                filename,
                modify(filename, ":r"),
                modify(filename, ":e"),
              }
              local items = {
                "Absolute path: " .. values[1],
                "Path relative to CWD: " .. values[2],
                "Path with wild card: " .. values[3],
                "Path relative to HOME: " .. values[4],
                "Filename: " .. values[5],
              }
              if vim.fn.isdirectory(filepath) == 0 then
                vim.list_extend(items, {
                  "Filename without extension: " .. values[6],
                  "Extension of the filename: " .. values[7],
                })
              end
              vim.ui.select(items, { prompt = "Choose to copy to clipboard:" }, function(choice, i)
                if not choice then
                  vim.notify("Selection cancelled")
                  return
                end
                if not i then
                  vim.notify("Invalid selection")
                  return
                end
                local result = values[i]
                vim.fn.setreg('"', result) -- Neovim unnamed register
                vim.fn.setreg("+", result) -- System clipboard
                vim.notify("Copied: " .. result)
              end)
            end,
          },
        },
      },
    },
  },
  keys = {
    { "<leader><space>", LazyVim.pick("live_grep", { root = false, hidden = true }), desc = "Grep (cwd)" },
    { "<leader>ff", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
    {
      "<leader>nt",
      function()
        Snacks.picker.grep({
          prompt = " ",
          -- pass your desired search as a static pattern
          search = "^\\s*- \\[ \\]",
          -- we enable regex so the pattern is interpreted as a regex
          regex = true,
          -- no “live grep” needed here since we have a fixed pattern
          live = false,
          -- restrict search to the current working directory
          dirs = { vim.fn.getcwd() },
          -- include files ignored by .gitignore
          args = { "--no-ignore" },
          -- Start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = "grep",
          format = "file",
          show_empty = true,
          supports_live = false,
          layout = "ivy",
        })
      end,
      desc = "[P]Search for incomplete tasks",
    },
  },
}
