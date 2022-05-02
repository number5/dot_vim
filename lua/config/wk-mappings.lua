local wk = require "which-key"
t = require "telescope.builtin"

-- Normal mode, no <leader> prefix
wk.register {
  ["<c-l>"] = { require("symbols-outline").toggle_outline, "Symbols Outline" },
  ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "go to definition" },
  ["gr"] = { "<cmd>Trouble lsp_references<cr>" },
  ["<leader><space>"] = { t.buffers, "telescope buffers" },
}

-- Normal mode, <leader> prefix
wk.register({
  -- ignored keys
  ["1"] = "which_key_ignore",
  ["2"] = "which_key_ignore",
  ["3"] = "which_key_ignore",
  ["4"] = "which_key_ignore",
  ["5"] = "which_key_ignore",
  ["6"] = "which_key_ignore",
  ["7"] = "which_key_ignore",
  ["8"] = "which_key_ignore",
  ["9"] = "which_key_ignore",

  h = { "<cmd>wincmd h<CR>", "move left" },
  j = { "<cmd>wincmd j<CR>", "move down" },
  k = { "<cmd>wincmd k<CR>", "move up" },
  l = { "<cmd>wincmd l<CR>", "move right" },

  b = { "<cmd>FzfLua buffers<CR>", "switch buffers" },
  e = { "<cmd>FzfLua files<CR>", "fzf files" },

  -- telescope
  t = {
    name = "+open",
    f = { t.find_files, "file" },
    r = { t.oldfiles, "recent" },
    gb = { t.git_branches, "git branch" },
    gc = { t.git_commits, "git commit" },
  },

  -- find
  f = {
    name = "+find",
    f = { t.current_buffer_fuzzy_find, "in file" },
    -- for syntax documentation see https://docs.rs/regex/1.5.4/regex/#syntax
    d = { t.live_grep, "in directory" },
    w = { t.grep_string, "word" },
    s = { t.lsp_document_symbols, "document symbols" },
    S = { t.lsp_workspace_symbols, "workspace symbols" },
    q = { t.quickfix, "in quickfix list" },
    h = { t.help_tags, "in help" },
    r = { t.lsp_references, "references" },
  },

  w = { "<cmd>w<CR>" },
  -- quit
  q = {
    name = "+quit",
    w = { "<cmd>q<CR>", "window" },
    W = { "<cmd>wincmd o<CR>", "all other windows" },
    b = { "<cmd>Bdelete<CR>", "buffer" },
    B = { "<cmd>BufOnly!<CR>", "all other buffers" },
    q = { "<cmd>cclose<CR>", "quickfix list" },
  },

  -- go
  g = {
    name = "+go",
    D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "declaration" },
    d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "definition" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition" },
  },

  -- show
  s = {
    name = "+show",
    E = { "<cmd>Trouble workspace_diagnostics<CR>", "workspace errors" },
    d = {
      function()
        require("gitsigns.actions").diffthis()
        vim.cmd "windo set foldcolumn=0"
      end,
      "git diff",
    },
    e = { "<cmd>lua vim.diagnostic.open_float()<CR>", "line errors" },
    h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "hover" },
    i = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "signature_help" },
    l = { "<cmd>Flog<CR>", "git log" },
    q = { "<cmd>copen<CR>", "quickfix list" },
    s = { "<cmd>G<CR>", "git status" },
    t = { "<cmd>TodoTrouble<CR>", "todos" },
    r = { "<cmd>lua vim.lsp.buf.references()<CR>", "lsp references" },
  },

  -- run
  r = {
    a = { "<cmd>lua t.lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>", "code action" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
  },

  -- diff
  d = {
    name = "+diff",
    g = { "<cmd>diffget<cr>", "get" },
    p = { "<cmd>diffput<cr>", "put" },
  },

  -- next
  n = {
    name = "+next",
    e = { vim.diagnostic.goto_next, "error" },
    q = { "<cmd>cnext<cr>", "quickfix item" },
    t = { "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", "trouble" },
    c = { require("gitsigns.actions").next_hunk, "change" },
  },
  -- previous
  p = {
    name = "+previous",
    e = { "<cmd>silent lua vim.lsp.diagnostic.goto_prev()<cr>", "error" },
    q = { "<cmd>cprevious<cr>", "quickfix item" },
    t = { "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", "trouble" },
    c = { "<cmd>lua require('gitsigns.actions').prev_hunk()<CR>", "change" },
  },
  -- Trouble
  x = {
    name = "Trouble",
    x = { "<cmd>Trouble<cr>", "Trouble trouble trouble" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Trouble workspace diagnostics" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Trouble document_diagnostics" },
    l = { "<cmd>Trouble loclist<cr>", "Trouble loclist" },
    q = { "<cmd>Trouble quickfix<cr>", "Trouble quickfix" },
  },
}, { prefix = "<leader>", mode = "n" })

-- visual mode, <leader> prefix
wk.register({
  d = {
    name = "+diff",
    g = { "<cmd>'<,'>diffget<cr>", "get" },
    p = { "<cmd>'<,'>diffput<cr>", "put" },
  },
}, { prefix = "<leader>", mode = "v" })

-- copy/paste, yank-ring
wk.register {
  ["p"] = { "<Plug>(YankyPutAfter)", "yank: put after" },
  ["P"] = { "<Plug>(YankyPutBefore)", "yank: put before" },
  ["gp"] = { "<Plug>(YankyPutAfter)", "yank: put after" },
  ["gP"] = { "<Plug>(YankyPutBefore)", "yank: put after" },
  ["y"] = { "<Plug>(YankyYank)", "yank" },
  ["<C-p>"] = { "<Plug>(YankyCycleForward)", "cycle to previous yank" },
}

wk.register({
  ["y"] = { "<Plug>(YankyYank)", "yank" },
}, { mode = "v" })
