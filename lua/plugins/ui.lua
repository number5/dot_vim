return {
  {
    "MunifTanjim/nougat.nvim", -- ☕
    event = "VeryLazy",
    config = function(_, _)
      require "themes.slanty"
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
  },
}
