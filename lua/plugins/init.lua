local present, packer = pcall(require, "plugins.packerInit")

if not present then
   error("loading plugins.packerInit failed")
   return false
end

-- local override_req = require("core.utils").override_req

local plugins = {

   { "nvim-lua/plenary.nvim" },
   {
      "wbthomason/packer.nvim",
      event = "VimEnter",
   },
   { "rebelot/kanagawa.nvim" },
   { "rebelot/heirline.nvim" },

}

return packer.startup(function(use)
   for _, v in pairs(plugins) do
      use(v)
   end
end)
