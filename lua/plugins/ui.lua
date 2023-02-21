return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
      local heirline = require("heirline")
      local statuslines = require("ui.heirline.statuslines")

      local opts = {
        statusline = statuslines.StatusLines,
      }

      heirline.setup(opts)
    end,
  },
}
