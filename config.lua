--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"

-- make foldtext look better
-- https://github.com/nvim-treesitter/nvim-treesitter/pull/390#issuecomment-709666989
vim.cmd([[
    function! GetSpaces(foldLevel)
        if &expandtab == 1
            " Indenting with spaces
            let str = repeat(" ", a:foldLevel / (&shiftwidth + 1) - 1)
            return str
        elseif &expandtab == 0
            " Indenting with tabs
            return repeat(" ", indent(v:foldstart) - (indent(v:foldstart) / &shiftwidth))
        endif
endfunction

    function! MyFoldText()
        let startLineText = getline(v:foldstart)
        let endLineText = trim(getline(v:foldend))
        let indentation = GetSpaces(foldlevel("."))
        let spaces = repeat(" ", 200)

        let str = indentation . startLineText . "..." . endLineText . spaces

        return str
endfunction

    " Custom display for text when folding
    set foldtext=MyFoldText()
]])

vim.opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldlevelstart = 1
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["f"] = { "<Plug>(easymotion-overwin-f)", "Easymotion" }
lvim.builtin.which_key.mappings["p"] = { "<cmd>lua require('telescope.builtin').find_files({ no_ignore = true })<cr>", "Find files (with ignored files)" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Find Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}
lvim.builtin.which_key.mappings["g"]["x"] = {
   "<cmd>lua vim.fn.execute'!git reset HEAD --hard'<cr>", "Reset hard to head"
}
lvim.builtin.which_key.mappings["g"]["S"] = {
   "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" 
}
lvim.builtin.which_key.mappings["g"]["l"] = {
   "<cmd>lua require 'gitsigns'.blame_line{full=true}<cr>", "Blame" 
}
lvim.builtin.which_key.mappings["m"] = {
  name = "+Easymotion",
  l = { "<Plug>(easymotion-bd-jk)", "Move line" },
}
lvim.builtin.which_key.mappings["l"]["c"] = {
   'gg/namespace<cr>W"jyt;f\\"Jyl/class<cr>W"Jyiw', "Copy class name into j register" 
}
lvim.builtin.which_key.mappings["g"]["d"] = { "<cmd>Git<cr>", "Diff view" }
lvim.builtin.which_key.mappings["s"]["w"] = {
   "<cmd>Telescope grep_string<cr>", "Search for work under cursor"
}

-- visual mode mappings
lvim.builtin.which_key.vmappings["g"] = {
    name = "Git",
    s = {
        -- needed to be a function because <cmd> exits visual mode, which makes the cursor position reset to start of visual selection
        -- https://stackoverflow.com/a/4338483
        -- also vim.fn.line("'<") and vim.fn.line("'>") doesn't work. it seems to select the previous selection
        function()
            local g = require('gitsigns')
            g.stage_hunk({vim.fn.line("v"), vim.fn.line(".")})
        end
        , "Stage Hunk"
    },
}
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end
-- you can overwrite the null_ls setup table (useful for setting the root_dir function)
-- lvim.lsp.null_ls.setup = {
--   root_dir = require("lspconfig").util.root_pattern("Makefile", ".git", "node_modules"),
-- }
-- or if you need something more advanced
-- lvim.lsp.null_ls.setup.root_dir = function(fname)
--   if vim.bo.filetype == "javascript" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "node_modules")(fname)
--       or require("lspconfig/util").path.dirname(fname)
--   elseif vim.bo.filetype == "php" then
--     return require("lspconfig/util").root_pattern("Makefile", ".git", "composer.json")(fname) or vim.fn.getcwd()
--   else
--     return require("lspconfig/util").root_pattern("Makefile", ".git")(fname) or require("lspconfig/util").path.dirname(fname)
--   end
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { exe = "black", filetypes = { "python" } },
--   { exe = "isort", filetypes = { "python" } },
--   {
--     exe = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { exe = "flake8", filetypes = { "python" } },
--   {
--     exe = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     args = { "--severity", "warning" },
--   },
--   {
--     exe = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
  {
    "easymotion/vim-easymotion",
  },
  {
    "AndrewRadev/sideways.vim",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "phpactor/phpactor",
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    module = "diffview",
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
        key_bindings = {
          file_panel = { q = "<Cmd>DiffviewClose<CR>" },
          view = { q = "<Cmd>DiffviewClose<CR>" },
        },
      }
    end,
  },
    {
        "tpope/vim-fugitive"
    },
    { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' },
}

require("lvim.lsp.manager").setup("phpactor")
require("lvim.lsp.manager").setup("cucumber_language_server", {
    cmd = { "cucumber-language-server", "--stdio" },
    filetypes = { "cucumber", "feature" },
    root_dir = require("lspconfig").util.find_git_ancestor,
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- easymotion
vim.g.EasyMotion_smartcase = 1
vim.opt.clipboard = ""

-- add parser for twig template
local parser_config = require'nvim-treesitter.parsers'.get_parser_configs()
parser_config.twig = {
  install_info = {
    url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
    files = {"src/parser.c"}
  },
  filetype = "twig",
  used_by = {}
}

vim.opt.timeoutlen = 500
