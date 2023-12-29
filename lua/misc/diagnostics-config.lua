local signs = { Error = "🤬", Warn = "🖐️", Hint = "☝️", Info = "🤓" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config {
  float = {
    source = "always",
    border = vim.g.FloatBorders,
    title = "Diagnostics",
    title_pos = "left",
    header = "",
  },
  virtual_text = false,
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}
