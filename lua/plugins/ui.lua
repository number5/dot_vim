return {
  {
    "rebelot/heirline.nvim",
    event = "UIEnter",
    config = function()
      local heirline = require("heirline")
      local statuslines = require("ui.heirline.statuslines")

      local opts = {
        tabline = statuslines.TopBar,
      }

      heirline.setup(opts)
    end,
  },
}
