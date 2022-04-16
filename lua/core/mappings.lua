local remap = vim.api.nvim_set_keymap

-- Remove annoying mapping
remap("n", "Q", "<Nop>", { noremap = true })

-- Quick Fix lists
remap("n", "<C-k>", ":cnext<CR>", { noremap = true })
remap("n", "<C-j>", ":cprev<CR>", { noremap = true })
remap("n", "<C-q>", ":call ToggleQFList(1)<CR>", { noremap = true })
remap("n", "<C-l>", ":call ToggleQFList(0)<CR>", { noremap = true })

-- Copy and paste
remap("v", "<leader>y", '"+y', { noremap = true })
remap("n", "<leader>y", '"+yy', { noremap = true })
remap("v", "<leader>p", '"+p', { noremap = true })
remap("v", "<leader>P", '"+P', { noremap = true })
remap("n", "<leader>p", '"+p', { noremap = true })
remap("n", "<leader>P", '"+P', { noremap = true })
remap("n", "Y", "y$", { noremap = true })

remap("v", "A-]", ">gv", { noremap = true })
remap("v", "A-[", "<gv", { noremap = true })

remap("n", "j", "gj", { noremap = true })
remap("n", "<Down>", "gj", { noremap = true })
remap("n", "k", "gk", { noremap = true })
remap("n", "<Up>", "gk", { noremap = true })

-- save
remap("n", "<leader>w", "<cmd>w<CR>", { noremap = true })
