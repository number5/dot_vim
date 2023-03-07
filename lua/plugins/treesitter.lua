return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      rainbow = {
        enable = true,
        -- list of languages you want to disable the plugin for
        disable = { "jsx", "cpp" },
        -- Which query to use for finding delimiters
        query = "rainbow-parens",
        strategy = require "ts-rainbow.strategy.local",
      },
    },
  },
}
