" Title:        Palenight theme
" Description:  A nice vim & neovim theme
" Last Change:  8 November 2021
" Maintainer:   Nitrobacck <https://github.com/nitrobacck>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:palenight")
    finish
endif
let g:palenight = 1

" Exposes the plugin's functions for use as commands in Vim.
command! -nargs=0 DisplayTime call example-plugin#DisplayTime()
command! -nargs=0 DefineWord call example-plugin#DefineWord()
command! -nargs=0 AspellCheck call example-plugin#AspellCheck()

so ./../colors/palenight.vim
