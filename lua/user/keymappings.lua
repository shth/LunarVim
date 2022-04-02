lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

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
