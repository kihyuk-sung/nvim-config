require('nvim-treesitter.configs').setup {
  ensure_installed = { 'c', 'lua', 'rust', 'ruby', 'vim', 'sql', 'java', 'kotlin', 'javascript', 'typescript', 'yaml' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}

