local M = {}
local colors = require("tokyonight.colors").setup()

local sep = "  "
local LeftSlantEnd = {
  provider = "",
  hl = { fg = colors.sumiInk1, bg = "bg" },
}

local modifiers = {
  dirname = ":.:s?/Users/bruce.wang/.dotfiles?dotfiles?:s?.config/nvim/lua/?Neovim?:s?/Users/Oli/Code?Code?",
}

M.vim_logo = {
  provider = " ",
  hl = { bg = colors.sumiInk1 },
}

M.cwd = {
  {
    provider = function()
      local cwd = vim.fn.fnamemodify(vim.loop.cwd(), modifiers.dirname or nil)
      return " " .. table.concat(vim.fn.split(cwd, "/"), sep) .. " "
    end,
    hl = { fg = "gray", bg = colors.sumiInk1, italic = true },
  },
  LeftSlantEnd,
}

M.filename = {
  -- Path to file
  {
    provider = function()
      local head = vim.fn.fnamemodify(vim.fn.expand "%:h", modifiers.dirname or nil)
      return " " .. table.concat(vim.fn.split(head, "/"), sep)
    end,
    hl = { fg = colors.boatYellow1, italic = true },
  },
  -- File name
  {
    {
      provider = function()
        local filetype_icon, filetype_hl = require("nvim-web-devicons").get_icon_by_filetype(vim.bo.filetype)
        return sep .. (filetype_icon and "%#" .. filetype_hl .. "#" .. filetype_icon .. " " or "")
      end,
    },
    {
      provider = function()
        return vim.fn.expand "%:t"
      end,
      hl = { fg = colors.fujiGray },
    },
    hl = { fg = colors.boatYellow1, italic = true },
  },
}

M.navic = {
  condition = function()
    return require("nvim-navic").is_available()
  end,
  init = function(self)
    self.navic = require("nvim-navic").get_location()
  end,
  update = "CursorMoved",
  {
    {
      condition = function(self)
        if #self.navic > 0 then
          return true
        else
          return false
        end
      end,
      provider = sep,
      hl = { fg = colors.boatYellow1, italic = true },
    },
    {
      provider = function(self)
        return self.navic
      end,
    },
  },
}

return M
