local M = {
  -- on_attach = require'lsp'.common_on_attach,
  settings = {
    yaml = {
      format = {
        enable = true,
      },
      hover = true,
      completion = true,
      customTags = {
        "!Base64",
        "!Cidr",
        "!FindInMap sequence",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!Join sequence",
        "!Ref",
        "!Select sequence",
        "!Split sequence",
        "!Sub sequence",
        "!Sub",
        "!And sequence",
        "!Condition",
        "!Equals sequence",
        "!If sequence",
        "!Not sequence",
        "!Or sequence",
      },
    },
  },
}

return M
