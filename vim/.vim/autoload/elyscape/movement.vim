let s:wrapping = v:false

function! elyscape#movement#EnableWrapping()
  nnoremap j gj
  nnoremap k gk
  let s:wrapping = v:true
endfunction

function! elyscape#movement#DisableWrapping()
  nunmap j
  nunmap k
  let s:wrapping = v:false
endfunction

function! elyscape#movement#ToggleWrapping()
  if s:wrapping
    call elyscape#movement#DisableWrapping()
  else
    call elyscape#movement#EnableWrapping()
  endif
endfunction
