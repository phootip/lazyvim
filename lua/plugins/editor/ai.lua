local enabled = true

local Snacks = require("snacks")
local copilot_exists = pcall(require, "copilot")

if copilot_exists then
  Snacks.toggle({
    name = "Copilot Completion",
    color = {
      enabled = "azure",
      disabled = "orange",
    },
    get = function()
      return not require("copilot.client").is_disabled()
    end,
    set = function(state)
      if state then
        require("copilot.command").enable()
      else
        require("copilot.command").disable()
      end
    end,
  }):map("<leader>as")
end

return {
  {
    "folke/sidekick.nvim",
    enabled = true,
    opts = {
      -- add any options here
      -- NOTE: enable later after have more rate limit
      nes = {
        enabled = true,
      },
      cli = {
        mux = {
          backend = "tmux",
          enabled = false,
        },
        tools = {
          gemini = {
            cmd = { "gemini", "-m", "gemini-2.5-flash" },
          },
          amazon_q = {
            cmd = { "kiro-cli" },
          },
        },
      },
    },
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<Tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "Goto/Apply Next Edit Suggestion",
      },
      {
        "<m-a>",
        function()
          require("sidekick.cli").toggle()
        end,
        mode = { "n", "x", "i", "t" },
        desc = "Sidekick Switch Focus",
      },
      {
        "<leader>aa",
        function()
          -- require("sidekick.cli").toggle({ name = "copilot", focus = true })
          require("sidekick.cli").toggle()
        end,
        desc = "Sidekick Toggle CLI",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").send({ msg = "{this}" })
        end,
        mode = { "x", "n" },
        desc = "Send This",
      },
      {
        "<leader>af",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send File",
      },
      {
        "<leader>av",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = { "x" },
        desc = "Send Visual Selection",
      },
      {
        "<leader>ap",
        function()
          require("sidekick.cli").prompt()
        end,
        desc = "Sidekick Ask Prompt",
        mode = { "n", "v" },
      },
      -- {
      --   "<leader>as",
      --   function()
      --     require("copilot.suggestion").toggle_auto_trigger()
      --     require("sidekick.nes").toggle()
      --     enabled = not enabled
      --     local status = enabled and "enabled" or "disabled"
      --     vim.notify("Copilot auto-trigger " .. status)
      --   end,
      --   desc = "Toggle Copilot suggestion",
      --   mode = { "n", "v" },
      -- },
    },
  },
}
