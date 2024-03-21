-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.cursorcolumn = true
-- vim.opt.wrap = true
vim.opt.scrolloff = 8
vim.o.showtabline = 2
vim.opt.conceallevel = 1
vim.opt.autoread = true
vim.opt.timeoutlen = 1000
-- vim.opt.listchars = "eol:$,tab:>-,trail:~,extends:>,precedes:<"
vim.opt.listchars = "tab:>-,trail:~,extends:>,precedes:<"

-- autoformat toggle <leader>uf

function openRepoNote()
  local file_name = vim.fs.basename(vim.fn.getcwd())
  local file_location = "~/phootip/personal/notes/2 repos/" .. file_name .. ".md"
  local f = vim.fn.filereadable(vim.fn.expand(file_location))
  vim.cmd("e " .. file_location)
  if f == 0 then
    vim.cmd("normal! ggO") -- add properties at the start
    vim.cmd("ObsidianTemplate repo.md")
    vim.cmd("normal! ddG") -- go to end of file
    vim.api.nvim_set_current_line("# " .. file_name)
    vim.cmd("normal! o") -- go to end of file
    vim.cmd("w") -- go to end of file
  end
end
vim.keymap.set("n", "<leader>nn", openRepoNote, { desc = "Open Repo Note" })

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end
