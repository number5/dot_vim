return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      typescript = { "deno_fmt" },
      lua = { "stylua" },
      sh = { "shfmt" },
    },
    -- LazyVim will merge the options you set here with builtin formatters.
    -- You can also define any custom formatters here.
    ---@type table<string,table>
    formatters = {
      -- -- Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
}
