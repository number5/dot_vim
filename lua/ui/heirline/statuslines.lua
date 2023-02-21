local components = require("ui.heirline.components")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local M = {}

M.StatusLines = {

  hl = function()
    if conditions.is_active() then
      return "StatusLine"
    else
      return "StatusLineNC"
    end
  end,

  -- the first statusline with no condition, or which condition returns true is used.
  -- think of it as a switch case with breaks to stop fallthrough.
  fallthrough = true,

  components.SpecialStatusline,
  components.TerminalStatusline,
  components.InactiveStatusline,
  components.DefaultStatusline,
}

M.TopBar = {
  fallthrough = false,
  components.None,
  {
    hl = { bg = utils.get_highlight("TabLine").bg },
    {
      components.Space,
      components.FileInfo,
      components.Align,
      components.CursorPosition,
      components.Space,
    },
  },
}

return M
