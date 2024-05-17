return {

  { "github/copilot.vim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  --  {
  --    "zbirenbaum/copilot.lua",
  --    cmd = "Copilot",
  --    event = "InsertEnter",
  --    config = function()
  --      require("copilot").setup {}
  --    end,
  --  },
}
