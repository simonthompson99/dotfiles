" some remaps specific to r buffers
" some leader mappings for neoterm
nnoremap <buffer> <leader>dv :T wrangleR::dtv(<C-R><C-W>)<cr> " dtv on word
nnoremap <buffer> <leader>rv :T wrangleR::rdtv(<C-R><C-W>)<cr> " rdtv on word
nnoremap <buffer> <leader>hd :T head(<C-R><C-W>)<cr> " head on word
nnoremap <buffer> <leader>st :T dplyr::glimpse(<C-R><C-W>)<cr> " str on word
nnoremap <buffer> <leader>nr :T nrow(<C-R><C-W>)<cr> " nrow on word

" map semicolon to arrow, double tap gives a semicolon
inoremap <buffer> ; <space><-
inoremap <buffer> ;; ;

