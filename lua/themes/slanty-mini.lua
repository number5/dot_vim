-- Converted from nougat.nvim (slanty) → mini.statusline
-- Requires: mini.statusline, mini.icons (optional, for filetype icons)

local color = {
  bg = "#1d2021",
  bg1 = "#3c3836",
  bg2 = "#504945",
  bg3 = "#665c54",
  fg = "#ebdbb2",
  red = "#fb4934",
  green = "#b8bb26",
  yellow = "#fabd2f",
  blue = "#83a598",
  purple = "#d3869b",
  orange = "#f38019",
  accent_green = "#98971a",
}

-- ── Highlight groups ────────────────────────────────────────────────────────

local function set_hls()
  -- Mode highlights  (fg = statusline bg so the "block" stands out)
  vim.api.nvim_set_hl(0, "SlantyModeNormal", { bg = color.fg, fg = color.bg, bold = true })
  vim.api.nvim_set_hl(0, "SlantyModeVisual", { bg = color.orange, fg = color.bg, bold = true })
  vim.api.nvim_set_hl(0, "SlantyModeInsert", { bg = color.blue, fg = color.bg, bold = true })
  vim.api.nvim_set_hl(0, "SlantyModeReplace", { bg = color.purple, fg = color.bg, bold = true })
  vim.api.nvim_set_hl(0, "SlantyModeCommand", { bg = color.green, fg = color.bg, bold = true })
  vim.api.nvim_set_hl(0, "SlantyModeTerminal", { bg = color.accent_green, fg = color.bg, bold = true })

  -- Git
  vim.api.nvim_set_hl(0, "SlantyGitBranch", { bg = color.purple, fg = color.bg })
  vim.api.nvim_set_hl(0, "SlantyGitAdded", { bg = color.green, fg = color.bg })
  vim.api.nvim_set_hl(0, "SlantyGitChanged", { bg = color.blue, fg = color.bg })
  vim.api.nvim_set_hl(0, "SlantyGitRemoved", { bg = color.red, fg = color.bg })

  -- File
  vim.api.nvim_set_hl(0, "SlantyFilename", { bg = color.bg3, fg = color.fg })
  vim.api.nvim_set_hl(0, "SlantyFiletype", { bg = color.bg1, fg = color.fg })

  -- Position
  vim.api.nvim_set_hl(0, "SlantyPosition", { bg = color.bg2, fg = color.blue })
  vim.api.nvim_set_hl(0, "SlantyPercent", { bg = color.blue, fg = color.bg })

  -- Diagnostics (fg only – drawn on the default statusline bg)
  vim.api.nvim_set_hl(0, "SlantyDiagError", { fg = color.red })
  vim.api.nvim_set_hl(0, "SlantyDiagWarn", { fg = color.yellow })
  vim.api.nvim_set_hl(0, "SlantyDiagInfo", { fg = color.blue })
  vim.api.nvim_set_hl(0, "SlantyDiagHint", { fg = color.green })
end

set_hls()

-- Re-apply after colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_hls })

-- ── Helpers ─────────────────────────────────────────────────────────────────

--- Wrap text in a %#HlGroup#…%* statusline highlight span.
local function hl(group, text)
  if text == "" then
    return ""
  end
  return string.format("%%#%s#%s%%*", group, text)
end

--- Mode label + highlight group.
local mode_map = {
  -- Normal
  n = { "NORMAL", "SlantyModeNormal" },
  no = { "N·OP", "SlantyModeNormal" },
  nov = { "N·OP", "SlantyModeNormal" },
  -- Visual
  v = { "VISUAL", "SlantyModeVisual" },
  V = { "V·LINE", "SlantyModeVisual" },
  [""] = { "V·BLCK", "SlantyModeVisual" },
  -- Select
  s = { "SELECT", "SlantyModeVisual" },
  S = { "S·LINE", "SlantyModeVisual" },
  --  [""] = { "S·BLCK", "SlantyModeVisual"  },
  -- Insert
  i = { "INSERT", "SlantyModeInsert" },
  -- Replace
  R = { "REPLACE", "SlantyModeReplace" },
  Rv = { "V·RPLC", "SlantyModeReplace" },
  -- Command
  c = { "COMMAND", "SlantyModeCommand" },
  cv = { "COMMAND", "SlantyModeCommand" },
  ce = { "COMMAND", "SlantyModeCommand" },
  -- Terminal
  t = { "TERMINAL", "SlantyModeTerminal" },
  ["!"] = { "SHELL", "SlantyModeTerminal" },
  -- Misc
  r = { "PROMPT", "SlantyModeNormal" },
  rm = { "MORE", "SlantyModeNormal" },
  ["r?"] = { "CONFIRM", "SlantyModeNormal" },
}

local function section_mode()
  local m = vim.api.nvim_get_mode().mode
  local info = mode_map[m] or { m:upper(), "SlantyModeNormal" }
  return hl(info[2], string.format(" %s ", info[1]))
end

local function section_git()
  -- Works with gitsigns.nvim or vim-fugitive (b:gitsigns_head / FugitiveHead)
  local branch = vim.b.gitsigns_head or (vim.fn.exists "*FugitiveHead" == 1 and vim.fn.FugitiveHead() or "")
  local parts = {}

  if branch ~= "" then
    parts[#parts + 1] = hl("SlantyGitBranch", string.format("  %s ", branch))
  end

  -- gitsigns diff summary
  local gs = vim.b.gitsigns_status_dict
  if gs then
    if (gs.added or 0) > 0 then
      parts[#parts + 1] = hl("SlantyGitAdded", string.format("+%d ", gs.added))
    end
    if (gs.changed or 0) > 0 then
      parts[#parts + 1] = hl("SlantyGitChanged", string.format("~%d ", gs.changed))
    end
    if (gs.removed or 0) > 0 then
      parts[#parts + 1] = hl("SlantyGitRemoved", string.format("-%d ", gs.removed))
    end
  end

  return table.concat(parts)
end

local function section_filename()
  local name = vim.fn.expand "%:t"
  if name == "" then
    name = "[No Name]"
  end

  local flags = ""
  if vim.bo.modified then
    flags = flags .. " "
  end
  if not vim.bo.modifiable then
    flags = flags .. "󰷪"
  elseif vim.bo.readonly then
    flags = flags .. "󰷧"
  end
  if flags ~= "" then
    flags = " " .. flags
  end

  return hl("SlantyFilename", string.format(" %s%s ", name, flags))
end

local function section_diagnostics()
  local counts = {
    { "ERROR", "󰅚", "SlantyDiagError" },
    { "WARN", " ", "SlantyDiagWarn" },
    { "INFO", " ", "SlantyDiagInfo" },
    { "HINT", "󰛩", "SlantyDiagHint" },
  }
  local parts = {}
  for _, d in ipairs(counts) do
    local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[d[1]] })
    if n > 0 then
      parts[#parts + 1] = hl(d[3], string.format("%s%d", d[2], n))
    end
  end
  if #parts == 0 then
    return ""
  end
  return " " .. table.concat(parts, " ") .. " "
end

local function section_filetype()
  local ft = vim.bo.filetype
  if ft == "" then
    return ""
  end
  return hl("SlantyFiletype", string.format(" %s ", ft))
end

local function section_position()
  local pos = hl("SlantyPosition", "  %l:%c ")
  local pct = hl("SlantyPercent", " %P ")
  return pos .. pct
end

-- ── Active / inactive statuslines ───────────────────────────────────────────

local function active_statusline()
  return table.concat {
    section_mode(),
    section_git(),
    section_filename(),
    "%=", -- spacer / right-align everything after this
    "%<", -- truncation point
    section_diagnostics(),
    section_filetype(),
    section_position(),
  }
end

local function inactive_statusline()
  return table.concat {
    section_filename(),
    "%=",
  }
end

-- ── mini.statusline setup ────────────────────────────────────────────────────
--
-- mini.statusline lets you supply a completely custom `content` table.
-- We bypass its built-in sections entirely and provide our own active/inactive
-- render functions.

require("mini.statusline").setup {
  content = {
    active = active_statusline,
    inactive = inactive_statusline,
  },
  use_icons = true, -- set false if you don't have a Nerd Font
  set_vim_settings = true,
}
