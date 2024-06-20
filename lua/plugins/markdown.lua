return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--config", vim.g.linterConfigFolder .. "/markdownlint.yaml", "--" },
        },
      },
    },
  },
}
