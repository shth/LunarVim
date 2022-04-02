require("lvim.lsp.manager").setup("phpactor")
require("lvim.lsp.manager").setup("cucumber_language_server", {
    cmd = { "cucumber-language-server", "--stdio" },
    filetypes = { "cucumber", "feature" },
    root_dir = require("lspconfig").util.find_git_ancestor,
})
