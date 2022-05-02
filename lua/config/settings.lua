load_options = function()
  local default_options = {
    autoread = true,
    backup = false, -- creates a backup file
    breakindent = true,
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 2, -- more space in the neovim command line for displaying messages
    colorcolumn = "99999", -- fixes indentline for now
    completeopt = { "menuone", "noselect" },
    conceallevel = 0, -- so that `` is visible in markdown files
    cursorline = true, -- highlight the current line
    expandtab = true, -- convert tabs to spaces
    fileencoding = "utf-8", -- the encoding written to a file
    foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    foldminilines = 2,
    gdefault = true, -- When on, the ":substitute" flag 'g' is default on
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    linebreak = true,
    mouse = "a", -- allow the mouse to be used in neovim
    number = false, -- set numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    pastetoggle = "C-P",
    pumheight = 10, -- pop up menu height
    relativenumber = false, -- set relative numbered lines
    scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    showbreak = "↪ ",
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    spell = false,
    spelllang = "en",
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    switchbuf = "useopen",
    tabstop = 2, -- insert 2 spaces for a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 250, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- set the title of window to the value of the titlestring
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion
    virtualedit = "onemore",
    wildmode = "longest,full",
    wrap = true, -- display lines as one long line
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  }

  ---  SETTINGS  ---
  vim.opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu
  vim.opt.shortmess:append "I" -- don't show the default intro message
  vim.opt.whichwrap:append "<,>,[,],h,l"

  for k, v in pairs(default_options) do
    vim.opt[k] = v
  end
end

load_options()
