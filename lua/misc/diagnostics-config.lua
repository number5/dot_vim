local fn = vim.fn
local api = vim.api

fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
--    

vim.diagnostic.config {
  float = {
    source = "always",
    border = vim.g.FloatBorders,
    title = "Diagnostics",
    title_pos = "left",
    header = "",
  },
  virtual_text = true,
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}

local severity_hl = {
  "DiagnosticError",
  "DiagnosticSignWarn",
  "DiagnosticInfo",
  "DiagnosticHint",
}
