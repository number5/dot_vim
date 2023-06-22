return {
  "RRethy/vim-illuminate",
  opts = {
    filetypes_denylist = {
      "dirvish",
      "fugitive",
      "md",
      "org",
      "norg",
    },
  },
  config = function(opts)
    require("illuminate").configure(opts)

    vim.keymap.set("n", "<leader>ti", "<cmd>IlluminateToggle<CR>", { desc = "[T]oggle [I]lluminate" })
    vim.keymap.set("n", "<leader>tf", require("illuminate").toggle_freeze_buf, { desc = "[F]reeze Illuminate" })
  end,
}
