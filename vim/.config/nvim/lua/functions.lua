local api = vim.api

-- get diff between saved and buffer
api.nvim_create_user_command(
	'DiffSaved',
	':w !diff % -',
	{}
)

-- Yank filenames and paths
api.nvim_create_user_command(
	'YankRelativePath',
	':let @+=expand("%")',
	{}
)
api.nvim_create_user_command(
	'YankAbsolutePath',
	':let @+=expand("%:p")',
	{}
)
api.nvim_create_user_command(
	'YankFilename',
	':let @+=expand("%:t")',
	{}
)
api.nvim_create_user_command(
	'YankDirectory',
	':let @+=expand("%:p:h")',
	{}
)

