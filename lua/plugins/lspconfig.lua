---since nvim-lspconfig and mason.nvim use different package names
---mappings from https://github.com/williamboman/mason-lspconfig.nvim/blob/main/lua/mason-lspconfig/mappings/server.lua
---@type table<string, string>
local lspToMasonMap = {
  bashls = "bash-language-server",
  biome = "biome", -- ts/js/json linter/formatter
  efm = "efm", -- linter integration, only used for shellcheck in zsh files
  emmet_language_server = "emmet-language-server", -- css/html completions
  jedi_language_server = "jedi-language-server", -- python lsp (with better hovers)
  gopls = "gopls",
  -- pylsp = "python-lsp-server",
  jsonls = "json-lsp",
  lua_ls = "lua-language-server",
  marksman = "marksman", -- markdown lsp
  taplo = "taplo", -- toml lsp
  typos_lsp = "typos-lsp", -- spellchecker for code
  -- vale_ls = "vale-ls", -- natural language linter
  yamlls = "yaml-language-server",
  nil_ls = "nil_ls",
}

--------------------------------------------------------------------------------

---@class (exact) lspConfiguration see https://github.com/neovim/nvim-lspconfig/blob/master/doc/lspconfig.txt#L46
---@field autostart? boolean
---@field capabilities? table <string, string|table|boolean|function>
---@field cmd? string[]
---@field filetypes? string[]
---@field handlers? table <string, function>
---@field init_options? table <string, string|table|boolean>
---@field on_attach? function(client, bufnr)
---@field on_new_config? function(new_config, root_dir)
---@field root_dir? function(filename, bufnr)
---@field settings? table <string, table>
---@field single_file_support? boolean

---@type table<string, lspConfiguration>
local serverConfigs = {}
for lspName, _ in pairs(lspToMasonMap) do
  serverConfigs[lspName] = {}
end

---Creates code-action keymap on attaching lsp to buffer
---@param mode string|string[]
---@param lhs string
---@param codeActionTitle string used by `string.find`
---@param keymapDesc string
local function codeActionKeymap(mode, lhs, codeActionTitle, keymapDesc)
  vim.keymap.set(mode, lhs, function()
    vim.lsp.buf.code_action {
      filter = function(action)
        return action.title:find(codeActionTitle)
      end,
      apply = true,
    }
  end, { buffer = true, desc = keymapDesc })
end

--------------------------------------------------------------------------------
-- BASH / ZSH

-- DOCS https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts

-- PENDING https://github.com/bash-lsp/bash-language-server/issues/1064
-- disable shellcheck via LSP to avoid double-diagnostics
serverConfigs.bashls = {
  settings = {
    bashIde = { shellcheckPath = "" },
  },
}


-- HACK use efm to use shellcheck with zsh files
-- EFM: Markdown & Shell
serverConfigs.efm = {
  cmd = { "efm-langserver", "-c", vim.g.linterConfigFolder .. "/efm.yaml" },
  filetypes = { "sh", "markdown" }, -- limit to filestypes needed
}

local efmDependencies = {
  "shellcheck", -- PENDING https://github.com/bash-lsp/bash-language-server/issues/663
}
--------------------------------------------------------------------------------
-- DOCS https://luals.github.io/wiki/settings/
serverConfigs.lua_ls = {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
        keywordSnippet = "Replace",
        showWord = "Disable", -- don't suggest common words as fallback
        postfix = ".", -- useful for `table.insert` and the like
      },
      diagnostics = {
        globals = { "vim" }, -- when contributing to nvim plugins missing a `.luarc.json`
        disable = { "trailing-space" }, -- formatte:1r already does that
      },
      hint = { -- inlay hints
        enable = true,
        setType = true,
        arrayIndex = "Disable",
      },
      workspace = { checkThirdParty = "Disable" }, -- FIX https://github.com/sumneko/lua-language-server/issues/679#issuecomment-925524834
      telemetry = { enable = false },
    },
  },
}



-- DOCS https://github.com/Microsoft/vscode/tree/main/extensions/json-language-features/server#configuration
-- Disable formatting in favor of biome
serverConfigs.jsonls = {
  init_options = {
    provideFormatter = false,
    documentRangeFormattingProvider = false,
  },
}

serverConfigs.nil_ls = {}
serverConfigs.gopls = {}
-- SIC needs to be enabled, can be removed with nvim 0.10 support for dynamic config
serverConfigs.biome = {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
    client.server_capabilities.documentRangeFormattingProvider = true
  end,
}

-- TYPOS
-- DOCS https://github.com/tekumara/typos-vscode#settings
serverConfigs.typos_lsp = {
  init_options = { diagnosticSeverity = "information" },
}

-- VALE
-- DOCS https://vale.sh/docs/integrations/guide/#vale-ls
-- DOCS https://vale.sh/docs/topics/config#search-process
-- serverConfigs.vale_ls = {
--   init_options = {
--     configPath = vim.g.linterConfigFolder .. "/vale/vale.ini",
--     installVale = true, -- needs to be set, since false by default
--     syncOnStartup = false,
--   },
--   -- just needs any root directory to work, we are providing the config already
--   root_dir = function()
--     return os.getenv "HOME"
--   end,
-- }

-- FIX https://github.com/errata-ai/vale-ls/issues/4
-- vim.env.VALE_CONFIG_PATH = vim.g.linterConfigFolder .. "/vale/vale.ini"

--------------------------------------------------------------------------------

-- DOCS https://github.com/redhat-developer/yaml-language-server/tree/main#language-server-settings
serverConfigs.yamlls = {
  settings = {
    yaml = {
      format = {
        enable = true,
        printWidth = 120,
        proseWrap = "always",
      },
    },
  },
  -- SIC needs enabling via setting *and* via capabilities to work. Probably
  -- fixed with nvim 0.10 supporting dynamic config changes
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = true
  end,
}
--------------------------------------------------------------------------------
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  mason_dependencies = vim.list_extend(efmDependencies, vim.tbl_values(lspToMasonMap)),
  config = function()
    require("lspconfig.ui.windows").default_options.border = vim.g.borderStyle

    -- Enable snippets-completion (nvim_cmp) and folding (nvim-ufo)
    local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
    lspCapabilities.textDocument.completion.completionItem.snippetSupport = true
    lspCapabilities.textDocument.foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }

    for lsp, serverConfig in pairs(serverConfigs) do
      serverConfig.capabilities = lspCapabilities
      require("lspconfig")[lsp].setup(serverConfig)
    end
  end,
}
