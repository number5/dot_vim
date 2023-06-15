return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
      require("ui.heirline.init").load()
    end,
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true, -- or `opts = {}`
  },
}
