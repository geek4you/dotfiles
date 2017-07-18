let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#force_py_version=3

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
if !exists('g:deoplete#omni#functions')
    let g:deoplete#omni#functions = {}
endif
let g:deoplete#omni#functions.python = 'jedi#completions'
let g:deoplete#omni#input_patterns.python = ['[^. *\t]\.\w*', '[^\s*@]\w*', '^\s*from\s.\+import \w*', '^\s*from \w*', '^\s*import \w*']

autocmd FileType python setlocal omnifunc=jedi#completions
" if !exists('g:deoplete#omni_patterns')
"     let g:deoplete#omni_patterns = {}
" endif
" let g:deoplete#omni_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
