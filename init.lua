-- debug only
vim.o.runtimepath = "/Users/bruce.wang/dotfiles/nvim/," .. vim.o.runtimepath

print(vim.o.runtimepath)

vim.g.mapleader = " "

local modules = {
   "core.options",
   "plugins",
   "core.mappings",
}

for _, module in ipairs(modules) do
   local ok, err = pcall(require, module)
   if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
   end
end

-- non plugin mappings
-- require("core.mappings").misc()

