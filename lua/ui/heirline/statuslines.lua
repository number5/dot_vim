local components = require("ui.heirline.components")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local M = {}

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
