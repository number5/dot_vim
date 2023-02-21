local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local M = {}

-- Utilities
M.Align = { provider = "%=" }
M.Space = { provider = " " }

-- File info
local FileIcon = {
  init = function(self)
    local file_name = self.file_name
    local extension = vim.fn.fnamemodify(file_name, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(file_name, extension, { default = true })
  end,
  provider = function(self)
    return self.icon
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
}

local FileName = {
  provider = function(self)
    local name = vim.fn.fnamemodify(self.file_name, ":t")
    if name == "" then
      return ""
    end
    return name
  end,
  hl = function(self)
    return { fg = "#EEFFFF", bold = true }
  end,
}

local RelativeFilePath = {
  provider = function(self)
    local path = vim.fn.fnamemodify(self.file_name, ":.")
    if path == "" then
      return ""
    end

    if not conditions.width_percent_below(#path, 0.25) then
      path = vim.fn.pathshorten(path)
    end
    return path
  end,
  hl = function(self)
    return { fg = utils.get_highlight("Normal").fg, italic = true }
  end,
}

M.FileInfo = {
  init = function(self)
    self.file_name = vim.api.nvim_buf_get_name(0)
  end,
  {
    { FileIcon, M.Space, FileName },
    M.Space,
    RelativeFilePath,
  },
}

-- Cursor Position
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  provider = "%3l:%2c %P",
}

local ScrollBar = {
  static = {
    -- sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
    sbar = { "🭶", "🭷", "🭸", "🭹", "🭺", "🭻" },
  },
  provider = function(self)
    -- local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    -- local lines = vim.api.nvim_buf_line_count(0)
    local curr_line = vim.fn.line(".")
    local lines = vim.fn.line("$")
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = utils.get_highlight("TelescopePromptTitle").fg, bg = utils.get_highlight("Normal").bg },
}

M.CursorPosition = {
  {
    Ruler,
    M.Space,
    ScrollBar,
  },
}

-- No statusline
M.None = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { "nofile", "prompt", "help", "quickfix" },
      filetype = { "^git.*", "fugitive", "neo-tree" },
    })
  end,
  {
    M.Align,
  },
}

M.SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      buftype = { "nofile", "prompt", "help", "quickfix" },
      filetype = { "^git.*", "fugitive" },
    })
  end,

  M.FileType,
  M.Space,
  M.HelpFileName,
  M.Align,
}

M.TerminalStatusline = {

  condition = function()
    return conditions.buffer_matches({ buftype = { "terminal" } })
  end,

  hl = { bg = "dark_red" },

  -- Quickly add a condition to the ViMode to only show it when buffer is active!
  { condition = conditions.is_active, M.ViMode, M.Space },
  M.FileType,
  M.Space,
  M.TerminalName,
  M.Align,
}

return M
