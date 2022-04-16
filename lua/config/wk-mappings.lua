local wk = require "which-key"
t = require "telescope.builtin"
t_ext = require("telescope").extensions

-- Normal mode, no <leader> prefix
wk.register {
  ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "go to definition" },
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

  -- c = {
  --  name = "+create",
  --  t = { "<cmd>bufnew<cr>", "new tab" },
  -- },

  -- open
  o = {
    name = "+open",
    f = { "<cmd>lua t.find_files()<CR>", "file" },
    r = { "<cmd>lua t.oldfiles()<CR>", "recent" },
    b = { "<cmd>lua t.buffers()<CR>", "buffer" },
    gb = { "<cmd>lua t.git_branches()<CR>", "git branch" },
    gc = { "<cmd>lua t.git_commits()<CR>", "git commit" },
  },

  -- find
  f = {
    name = "+find",
    f = { "<cmd>lua t.current_buffer_fuzzy_find()<CR>", "in file" },
    -- for syntax documentation see https://docs.rs/regex/1.5.4/regex/#syntax
    d = { "<cmd>lua t.live_grep()<CR>", "in directory" },
    w = { "<cmd>lua t.grep_string()<CR>", "word" },
    s = { "<cmd>lua t.lsp_document_symbols()<CR>", "document symbols" },
    S = { "<cmd>lua t.lsp_workspace_symbols()<CR>", "workspace symbols" },
    q = { "<cmd>lua t.quickfix()<CR>", "in quickfix list" },
    h = { "<cmd>lua t.help_tags()<CR>", "in help" },
    r = { "<cmd>lua t.lsp_references()<CR>", "references" },
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
    D = { "<cmd>Dirbuf<CR>", "directory buffer" },
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
    name = "+run",
    R = { "<cmd>lua require('spectre').open()<CR><bar><cmd>wincmd T<CR>", "search & replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR><bar><cmd>wincmd T<CR>", "replace word" },
    a = { "<cmd>lua t.lsp_code_actions(require('telescope.themes').get_cursor({}))<CR>", "code action" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "rename" },
  },

  -- terminal
  t = {
    name = "+terminal",
    c = { "<cmd>T clear<CR>", "clear" },
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
    e = { "<cmd>silent lua vim.lsp.diagnostic.goto_next()<cr>", "error" },
    q = { "<cmd>cnext<cr>", "quickfix item" },
    t = { "<cmd>lua require('trouble').next({skip_groups = true, jump = true})<cr>", "trouble" },
    c = { "<cmd>lua require('gitsigns.actions').next_hunk()<CR>", "change" },
  },
  -- previous
  p = {
    name = "+previous",
    e = { "<cmd>silent lua vim.lsp.diagnostic.goto_prev()<cr>", "error" },
    q = { "<cmd>cprevious<cr>", "quickfix item" },
    t = { "<cmd>lua require('trouble').previous({skip_groups = true, jump = true})<cr>", "trouble" },
    c = { "<cmd>lua require('gitsigns.actions').prev_hunk()<CR>", "change" },
  },
}, { prefix = "<leader>" })

-- visual mode, <leader> prefix
wk.register({
  d = {
    name = "+diff",
    g = { "<cmd>'<,'>diffget<cr>", "get" },
    p = { "<cmd>'<,'>diffput<cr>", "put" },
  },
}, { prefix = "<leader>", mode = "v" })
