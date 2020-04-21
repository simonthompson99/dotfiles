" some leader mappings for neoterm
nnoremap <leader>dv :T wrangleR::dtv(<C-R><C-W>)<cr> " dtv on word
nnoremap <leader>rv :T wrangleR::rdtv(<C-R><C-W>)<cr> " rdtv on word
nnoremap <leader>hd :T head(<C-R><C-W>)<cr> " head on word
nnoremap <leader>st :T dplyr::glimpse(<C-R><C-W>)<cr> " str on word
nnoremap <leader>nr :T nrow(<C-R><C-W>)<cr> " nrow on word

" map semicolon to arrow, double tap gives a semicolon
inoremap ; <space><-<space>
inoremap ;; ;

