require('lualine').setup {
  options = {
    icons_enables = true,
    theme = 'gruvbox',
  },
  sections = {
    lualine_a = {
      {
        'filename',
        path = 1,
      }
    }
  }
}
