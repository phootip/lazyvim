return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
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
  },
}
