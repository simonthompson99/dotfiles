local api = vim.api

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
--
-- convoluted way to yank selection as '<,'> doesn't work right
api.nvim_create_user_command(
	'YankSelectionToSystemReg',
	':normal gv "+y',
	{}
)

-- get diff between saved and buffer
api.nvim_create_user_command(
	'DiffSaved',
	':w !diff % -',
	{}
)
