
vim.opt.clipboard = ""
vim.opt.timeoutlen = 500

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
