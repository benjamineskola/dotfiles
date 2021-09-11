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
      hidden_files = true,
    },
  },
}

local M = {}
require'telescope'.project = function()
  require'telescope'.extensions.project.project{
    attach_mappings = function(_, map)
      map('i', '<cr>', require'telescope._extensions.project.actions'.change_working_directory)
      map('n', '<cr>', require'telescope._extensions.project.actions'.change_working_directory)
      return true
    end,
    display_type = 'full',
  }
end
