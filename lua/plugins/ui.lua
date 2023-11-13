return {
  {
    "MunifTanjim/nougat.nvim",
    event = "VeryLazy",
    opts = function()
      require "themes.slanty"
    end,
    config = true,
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
}
