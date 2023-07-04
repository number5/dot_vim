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
  keys = {
    {
      "<leader>ti",
      "<cmd>IlluminateToggle<CR>",
      { desc = "[T]oggle [I]lluminate" },
    },
    {
      "<leader>tf",
      require("illuminate").toggle_freeze_buf,
      { desc = "[F]reeze Illuminate" },
    },
  },
}
