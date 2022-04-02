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

