autocmd BufWritePost *.scala :EnTypeCheck
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
if !exists('g:deoplete#omni#functions')
    let g:deoplete#omni#functions = {}
endif
let g:deoplete#omni#functions.scala= 'EnCompleteFunc'
let g:deoplete#omni#input_patterns.scala = ['[^. *\t]\.\w*']
