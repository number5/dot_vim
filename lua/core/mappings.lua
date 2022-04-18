local remap = vim.api.nvim_set_keymap

-- Remove annoying mapping
remap("n", "Q", "<Nop>", { noremap = true })

-- Quick Fix lists
remap("n", "<C-k>", ":cnext<CR>", { noremap = true })
remap("n", "<C-j>", ":cprev<CR>", { noremap = true })

remap("v", "A-]", ">gv", { noremap = true })
remap("v", "A-[", "<gv", { noremap = true })

remap("n", "j", "gj", { noremap = true })
remap("n", "<Down>", "gj", { noremap = true })
remap("n", "k", "gk", { noremap = true })
remap("n", "<Up>", "gk", { noremap = true })
