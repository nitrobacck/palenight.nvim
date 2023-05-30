" -----------------------------------------------------------------------------
" File: palenight.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/palenight-community/palenight
" -----------------------------------------------------------------------------

function! palenight#invert_signs_toggle()
  if g:palenight_invert_signs == 0
    let g:palenight_invert_signs=1
  else
    let g:palenight_invert_signs=0
  endif

  colorscheme palenight
endfunction

" Search Highlighting {{{

function! palenight#hls_show()
  set hlsearch
  call palenightHlsShowCursor()
endfunction

function! palenight#hls_hide()
  set nohlsearch
  call palenightHlsHideCursor()
endfunction

function! palenight#hls_toggle()
  if &hlsearch
    call palenight#hls_hide()
  else
    call palenight#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
