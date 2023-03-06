local M = {
  init = function()
    local tabline = require("heirline").tabline
    local buflist = tabline._buflist[1]
    buflist._picker_labels = {}
    buflist._show_picker = true
    vim.cmd.redrawtabline()
    local char = vim.fn.getcharstr()
    local bufnr = buflist._picker_labels[char]
    if bufnr then
      vim.api.nvim_win_set_buf(0, bufnr)
    end
    buflist._show_picker = false
    vim.cmd.redrawtabline()
  end,
}

-- Filetypes where certain elements of the statusline will not be shown
local filetypes = {
  "^git.*",
  "fugitive",
  "alpha",
  "^neo--tree$",
  "^neotest--summary$",
  "^neo--tree--popup$",
  "^NvimTree$",
  "^toggleterm$",
}

-- Buftypes which should cause elements to be hidden
local buftypes = {
  "nofile",
  "prompt",
  "help",
  "quickfix",
}

-- Filetypes which force the statusline to be inactive
local force_inactive_filetypes = {
  "^aerial$",
  "^alpha$",
  "^chatgpt$",
  "^DressingInput$",
  "^frecency$",
  "^lazy$",
  "^netrw$",
  "^TelescopePrompt$",
  "^undotree$",
}

---Load the bufferline, tabline and statusline. Extracting this to a seperate
---function allows us to call it from autocmds and preserve colors
function M.load()
  local heirline = require "heirline"
  local conditions = require "heirline.conditions"

  local statusline = require "ui.heirline.statusline"
  local statuscolumn = require "ui.heirline.statuscolumn"
  local winbar = require "ui.heirline.winbar"

  local align = { provider = "%=" }
  local spacer = { provider = " " }

  heirline.load_colors(require("tokyonight.colors").setup())
  heirline.setup {
    statusline = {
      static = {
        filetypes = filetypes,
        buftypes = buftypes,
        force_inactive_filetypes = force_inactive_filetypes,
      },
      condition = function(self)
        return not conditions.buffer_matches {
          filetype = self.force_inactive_filetypes,
        }
      end,
      statusline.VimMode,
      statusline.GitBranch,
      statusline.FileNameBlock,
      statusline.LspDiagnostics,
      align,
      statusline.Lazy,
      statusline.FileType,
      statusline.FileEncoding,
      statusline.Session,
      statusline.SearchResults,
      statusline.Ruler,
    },
    statuscolumn = {
      condition = function()
        return not conditions.buffer_matches {
          buftype = buftypes,
          filetype = force_inactive_filetypes,
        }
      end,
      static = statuscolumn.static,
      init = statuscolumn.init,
      statuscolumn.signs,
      align,
      statuscolumn.line_numbers,
      spacer,
      statuscolumn.folds,
      statuscolumn.git_signs,
    },
    winbar = {
      {
        condition = function()
          return conditions.buffer_matches {
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "alpha", "oil" },
          }
        end,
        init = function()
          vim.opt_local.winbar = nil
        end,
      },
      winbar.filename,
      winbar.navic,
    },
  }
end

return M
