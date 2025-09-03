-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("x", "p", "P")
vim.keymap.set("x", "P", "p")
vim.keymap.set({ "n", "x" }, "x", '"_x')
vim.keymap.set({ "n", "x" }, "X", '"_X')
vim.keymap.set("n", "dx", '""dd')
vim.keymap.set({ "n" }, "vil", "^vg_")
vim.keymap.set({ "n" }, "yil", "^yg_")
vim.keymap.set({ "n" }, "ci ", "ciW")
vim.keymap.set({ "n" }, "vi ", "viW")
vim.keymap.set({ "n" }, "yi ", "yiW")
vim.keymap.set({ "n" }, "val", "0v$h")
vim.keymap.set("n", "<c-_>", "gcc", { remap = true })
vim.keymap.set("n", "<c-/>", "gcc", { remap = true })
vim.keymap.set("v", "<C-_>", "gc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc", { remap = true })

vim.keymap.set("v", "J", "gJ", { silent = true })
vim.keymap.set("v", "gJ", "J", { silent = true })

-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { silent = true })
-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-j>", "<CMD>TmuxNavigateDown<CR>", { silent = true })
-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-k>", "<CMD>TmuxNavigateUp<CR>", { silent = true })
-- vim.keymap.set({ "n", "x", "i", "t" }, "<C-l>", "<CMD>TmuxNavigateRight<CR>", { silent = true })

-- tab switching
vim.keymap.set({ "n", "x", "i" }, "<M-u>", "<cmd>tabp<cr>")
vim.keymap.set({ "n", "x", "i" }, "<M-i>", "<cmd>tabn<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-h>", "<cmd>wincmd h<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-j>", "<cmd>wincmd j<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-k>", "<cmd>wincmd k<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-l>", "<cmd>wincmd l<cr>")
vim.keymap.set({ "n", "x", "i", "t" }, "<M-6>", function()
  print("buftype: " .. vim.o.buftype)
  print("filetype: " .. vim.o.filetype)
end)
-- switch terminal while keeping cursor pos
vim.keymap.set({ "t" }, "<M-u>", function()
  vim.cmd("stopinsert")
  -- using vim.cmd("tabp") breaks cursor pos, why?
  local keys = vim.api.nvim_replace_termcodes("<M-u>", true, false, true)
  vim.api.nvim_feedkeys(keys, "m", false)
end)
vim.keymap.set({ "t" }, "<M-i>", function()
  local keys = vim.api.nvim_replace_termcodes("<M-i>", true, false, true)
  if vim.o.filetype == "fzf" then
    vim.api.nvim_feedkeys(keys, "n", false)
  else
    vim.cmd("stopinsert")
    -- using vim.cmd("tabp") breaks cursor pos, why?
    vim.api.nvim_feedkeys(keys, "m", false)
  end
end)
-- unfold next foldable
vim.keymap.set({ "n" }, "<Enter>", function()
  if vim.o.buftype ~= "quickfix" and vim.o.filetype ~= "vim" then
    local line = vim.fn.line(".")
    if vim.fn.foldclosed(line) ~= -1 then
      return "zo"
    else
      return "zjzo"
    end
  else
    return "<Enter>"
  end
end, { expr = true, replace_keycodes = true })
vim.keymap.set({ "n" }, "<BS>", "zc")

vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "g_")
vim.keymap.set("n", "]<Tab>", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[<Tab>", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<leader>tt", "<cmd>tabnew | term<cr>")
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>")
vim.keymap.set("n", "<leader>td", "<cmd>tabclose<cr>")
vim.keymap.set("n", "<leader>to", "<cmd>tabonly<cr>")
vim.keymap.set("n", "<leader>tr", "<cmd>TabRename <cr>")

vim.keymap.set("n", "<leader>.", "<cmd>@:<cr>")
-- diff
vim.keymap.set("n", "<leader>dd", "<cmd>windo diffthis<cr>")
vim.keymap.set("n", "<leader>dgo", "<cmd>diffget<cr>")
vim.keymap.set("n", "<leader>dgl", "<cmd>.,.diffget<cr>")
vim.keymap.set("x", "<leader>dgo", "<cmd>'<,'>diffget<cr>")
vim.keymap.set("n", "<leader>dpp", "<cmd>diffput<cr>")
vim.keymap.set("n", "<leader>dpl", "<cmd>.,.diffput<cr>")
vim.keymap.set("x", "<leader>dpp", "<cmd>'<,'>diffput<cr>")

-- terminal change mode
-- vim.api.nvim_del_keymap("t", "<Esc><Esc>")
vim.keymap.set({ "t" }, "<esc>", "<c-\\><c-n>")
vim.keymap.set({ "t" }, "<F1>", "<esc>")
vim.keymap.set({ "t" }, "<M-esc>", "<esc>")
-- vim.keymap.set({ "n", "x", "i" }, "<F1>", "<ESC>")
-- vim.keymap.set({ "t" }, "<F1>", "<c-\\><c-n>")
-- vim.keymap.set({ "t" }, "<M-esc>", "<c-\\><c-n>")

vim.keymap.set({ "n" }, "q", function()
  if vim.bo.buftype == "terminal" then
    vim.api.nvim_feedkeys("i", "n", true)
  else
    vim.api.nvim_feedkeys("q", "n", true)
  end
end)

-- vim.keymap.set("", "<leader>ct", function()
--   vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 1 or 0
-- end)
-- vim.keymap.del("n", "<leader>w-")
-- mutlicusor
vim.api.nvim_del_keymap("n", "<esc>")
local mc = require("multicursor-nvim")
local keys = vim.api.nvim_replace_termcodes("<cmd>noh<cr><esc>", true, false, true)
vim.keymap.set("n", "<esc>", function()
  if not mc.cursorsEnabled() then
    mc.enableCursors()
  elseif mc.hasCursors() then
    mc.clearCursors()
  else
    vim.api.nvim_feedkeys(keys, "n", true)
  end
end)
