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
    { 'ThePrimeagen/harpoon', requires = 'nvim-lua/plenary.nvim' },
}

-- TODO: move this into packer syntax
-- easymotion
vim.g.EasyMotion_smartcase = 1
