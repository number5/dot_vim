return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    config = function()
      require("ui.heirline.init").load()
    end,
  },
}
