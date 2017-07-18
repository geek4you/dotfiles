" Use deoplete.
let g:deoplete#enable_at_startup = 1
" Use smartcase.
let g:deoplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:deoplete#sources#syntax#min_keyword_length = 3
let g:deoplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
endif
let g:deoplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     deoplete#mappings#undo_completion()
inoremap <expr><C-Space> deoplete#mappings#manual_complete()
imap <buffer> <Nul> <C-Space>
smap <buffer> <Nul> <C-Space>

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return deoplete#mappings#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-y>  deoplete#mappings#close_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? deoplete#mappings#close_popup() . "\<Space>" : "\<Space>"

" AutoComplPop like behavior.
"let g:deoplete#enable_auto_select = 1

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:deoplete#omni_patterns')
  let g:deoplete#omni_patterns = {}
endif
let g:deoplete#omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:deoplete#omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:deoplete#omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:deoplete#omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
