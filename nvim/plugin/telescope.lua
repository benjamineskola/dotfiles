require'telescope'.load_extension('project')
require('telescope').setup {
	defaults = {
    mappings = {
			i = {
        ["<esc>"] = require'telescope.actions'.close,
			},
			n = {
        ["<esc>"] = require'telescope.actions'.close,
			},
		},
	},
  extensions = {
    project = {
      base_dirs = {
        {'~/Code', max_depth = 2 },
        {'~/govuk', max_depth = 2 },
        {'~/.config', max_depth = 1 },
      },
    },
  },
}
