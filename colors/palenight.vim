" -----------------------------------------------------------------------------
" File: palenight.vim
" Description: Retro groove color scheme for Vim
" Author: nitrobacck <gruvbox.com/nitrobacck>
" Source: https://github.com/nitrobacck/palenight
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------

" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='palenight'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}

" Global Settings: {{{

if !exists('g:palenight_bold')
  let g:palenight_bold=1
endif
if !exists('g:palenight_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:palenight_italic=1
  else
    let g:palenight_italic=0
  endif
endif
if !exists('g:palenight_undercurl')
  let g:palenight_undercurl=1
endif
if !exists('g:palenight_underline')
  let g:palenight_underline=1
endif
if !exists('g:palenight_inverse')
  let g:palenight_inverse=1
endif

if !exists('g:palenight_guisp_fallback') || index(['fg', 'bg'], g:palenight_guisp_fallback) == -1
  let g:palenight_guisp_fallback='NONE'
endif

if !exists('g:palenight_improved_strings')
  let g:palenight_improved_strings=0
endif

if !exists('g:palenight_improved_warnings')
  let g:palenight_improved_warnings=0
endif

if !exists('g:palenight_termcolors')
  let g:palenight_termcolors=256
endif

if !exists('g:palenight_invert_indent_guides')
  let g:palenight_invert_indent_guides=0
endif

if exists('g:palenight_contrast')
  echo 'g:palenight_contrast is deprecated; use g:palenight_contrast_light and g:palenight_contrast_dark instead'
endif

if !exists('g:palenight_contrast_dark')
  let g:palenight_contrast_dark='medium'
endif

if !exists('g:palenight_contrast_light')
  let g:palenight_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')


" }}}
" Palette Utility Functions: {{{

function! s:Color(name, default, ...)
  " color already set, validate option
  if has_key(s:gb, a:name)
    let l:color = s:gb[a:name]

    if type(l:color) == type('')
      " gui color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][0] = l:color
      return 1
    elseif type(l:color) == type(0)
      " terminal color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][1] = l:color
      return 1
    elseif type(l:color) == type([])
          \ && len(l:color) == 2
          \ && type(l:color[0]) == type('')
          \ && type(l:color[1]) == type(0)
      " gui and terminal color
      return 1
    else
      " invalid value
      echo a:name 'is invalid, usage: let g:palenight_colors.color = (["#ffffff", 255]|"#ffffff"|255)'
      return 0
    endif

  endif

  " set default option
  let s:gb[a:name] = a:default
  return 1
endfunction


" }}}

" Palette: {{{

" get the global palenight palette options, if any
let g:palenight_colors = get(g:, 'palenight_colors', {})
" initialize the script palette
let s:gb = copy(g:palenight_colors)
let g:current_palenight_colors = s:gb

" color gor use d74b67
" color string c3e88d find 6c27da

" set palette default colors
call s:Color('dark0',       ['#292d3e', 235]) " BG
call s:Color('dark0_hard',  ['#a15454', 234]) " IDK
call s:Color('dark0_soft',  ['#202625', 236])
call s:Color('dark1',       ['#292d3e', 237]) " line on the left
call s:Color('dark2',       ['#484550', 239])
call s:Color('dark3',       ['#111111', 241]) " IDK
call s:Color('dark4',       ['#495061', 243]) " NUMS ON THE SIDE
call s:Color('dark4_256',   ['#111111', 243]) " IDK

call s:Color('gray_245',    ['#697098', 245]) " COMMENTS
call s:Color('gray_244',    ['#111111', 244]) " OLD 6d8485

call s:Color('light0_hard', ['#111111', 230])
call s:Color('light0',      ['#717889', 229])
call s:Color('light0_soft', ['#717889', 228])
call s:Color('light1',      ['#bfc7d5', 223]) " CMDS
call s:Color('light2',      ['#ff5370', 250])
call s:Color('light3',      ['#c3e88d', 248]) 
call s:Color('light4',      ['#82b1ff', 246])
call s:Color('light4_256',  ['#111111', 246])

call s:Color('bright_red',     ['#f1506d', 167]) " TYPES I THINK
call s:Color('bright_green',   ['#c3e88d', 142]) " STRINGS
call s:Color('bright_yellow',  ['#fabd2f', 214])
call s:Color('bright_blue',    ['#ff5370', 109]) " USE like variable
call s:Color('bright_purple',  ['#d386cb', 175])
call s:Color('bright_aqua',    ['#80b4bf', 108]) " 82b1ff
call s:Color('bright_orange',  ['#b9c2cf', 208]) " BRACE

call s:Color('neutral_red',    ['#1dcc95', 124])
call s:Color('neutral_green',  ['#1dcc95', 106])
call s:Color('neutral_yellow', ['#d79921', 172])
call s:Color('neutral_blue',   ['#458588', 66])
call s:Color('neutral_purple', ['#b1629c', 132])
call s:Color('neutral_aqua',   ['#7baab0', 72])
call s:Color('neutral_orange', ['#ded752', 166])

call s:Color('faded_red',      ['#82b1ff', 88]) " 6c27da
call s:Color('faded_green',    ['#9c9627', 100])
call s:Color('faded_yellow',   ['#82b1ff', 136]) " CAND TEST old c48829
call s:Color('faded_blue',     ['#82b1ff', 24])
call s:Color('faded_purple',   ['#c3e88d', 96]) " CANDIDATE STRING OLD 783f8f
call s:Color('faded_aqua',     ['#427b58', 65])
call s:Color('faded_orange',   ['#c3e88d', 130]) " VERY STRONG_BLUE #0603af

call s:Color('none', ['NONE','NONE'])
call s:Color('NONE', ['NONE','NONE'])
call s:Color('None', ['NONE','NONE'])

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:palenight_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:palenight_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:palenight_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:palenight_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:palenight_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:palenight_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:palenight_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:palenight_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:palenight_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:palenight_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
call s:Color('bg0', s:bg0)
call s:Color('bg1', s:bg1)
call s:Color('bg2', s:bg2)
call s:Color('bg3', s:bg3)
call s:Color('bg4', s:bg4)

call s:Color('gray', s:gray)

call s:Color('fg0', s:fg0)
call s:Color('fg1', s:fg1)
call s:Color('fg2', s:fg2)
call s:Color('fg3', s:fg3)
call s:Color('fg4', s:fg4)

call s:Color('fg4_256', s:fg4_256)

call s:Color('red',    s:red)
call s:Color('green',  s:green)
call s:Color('yellow', s:yellow)
call s:Color('blue',   s:blue)
call s:Color('purple', s:purple)
call s:Color('aqua',   s:aqua)
call s:Color('orange', s:orange)

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:gb.bg0[0]
  let g:terminal_color_8 = s:gb.gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:gb.red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:gb.green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:gb.yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:gb.blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:gb.purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:gb.aqua[0]

  let g:terminal_color_7 = s:gb.fg4[0]
  let g:terminal_color_15 = s:gb.fg1[0]
endif

" }}}
" Setup Terminal Colors For Vim with termguicolors: {{{

if exists('*term_setansicolors')
  let g:terminal_ansi_colors = repeat([0], 16)

  let g:terminal_ansi_colors[0] = s:gb.bg0[0]
  let g:terminal_ansi_colors[8] = s:gb.gray[0]

  let g:terminal_ansi_colors[1] = s:gb.neutral_red[0]
  let g:terminal_ansi_colors[9] = s:gb.red[0]

  let g:terminal_ansi_colors[2] = s:gb.neutral_green[0]
  let g:terminal_ansi_colors[10] = s:gb.green[0]

  let g:terminal_ansi_colors[3] = s:gb.neutral_yellow[0]
  let g:terminal_ansi_colors[11] = s:gb.yellow[0]

  let g:terminal_ansi_colors[4] = s:gb.neutral_blue[0]
  let g:terminal_ansi_colors[12] = s:gb.blue[0]

  let g:terminal_ansi_colors[5] = s:gb.neutral_purple[0]
  let g:terminal_ansi_colors[13] = s:gb.purple[0]

  let g:terminal_ansi_colors[6] = s:gb.neutral_aqua[0]
  let g:terminal_ansi_colors[14] = s:gb.aqua[0]

  let g:terminal_ansi_colors[7] = s:gb.fg4[0]
  let g:terminal_ansi_colors[15] = s:gb.fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:gb.orange
if exists('g:palenight_hls_cursor')
  let s:hls_cursor = get(s:gb, g:palenight_hls_cursor)
endif

let s:hls_highlight = s:gb.yellow
if exists('g:palenight_hls_highlight')
  let s:hls_highlight = get(s:gb, g:palenight_hls_highlight)
endif

let s:number_column = s:none
if exists('g:palenight_number_column')
  let s:number_column = get(s:gb, g:palenight_number_column)
endif

let s:sign_column = s:gb.bg1
if exists('g:palenight_sign_column')
  let s:sign_column = get(s:gb, g:palenight_sign_column)
endif

let s:color_column = s:gb.bg1
if exists('g:palenight_color_column')
  let s:color_column = get(s:gb, g:palenight_color_column)
endif

let s:cursorline = s:gb.bg1
if exists('g:palenight_cursorline')
  let s:cursorline = get(s:gb, g:palenight_cursorline)
endif

let s:vert_split = s:gb.bg0
if exists('g:palenight_vert_split')
  let s:vert_split = get(s:gb, g:palenight_vert_split)
endif

let s:invert_signs = ''
if exists('g:palenight_invert_signs')
  if g:palenight_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:palenight_invert_selection')
  if g:palenight_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:palenight_invert_tabline')
  if g:palenight_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:tabline_sel = s:gb.green
if exists('g:palenight_tabline_sel')
  let s:tabline_sel = get(s:gb, g:palenight_tabline_sel)
endif

let s:italicize_comments = s:italic
if exists('g:palenight_italicize_comments')
  if g:palenight_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:palenight_italicize_strings')
  if g:palenight_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

let s:italicize_operators = ''
if exists('g:palenight_italicize_operators')
  if g:palenight_italicize_operators == 1
    let s:italicize_operators = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:palenight_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert highlighting
    if g:palenight_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" palenight Hi Groups: {{{

" memoize common hi groups
call s:HL('palenightFg0', s:gb.fg0)
call s:HL('palenightFg1', s:gb.fg1)
call s:HL('palenightFg2', s:gb.fg2)
call s:HL('palenightFg3', s:gb.fg3)
call s:HL('palenightFg4', s:gb.fg4)
call s:HL('palenightGray', s:gb.gray)
call s:HL('palenightBg0', s:gb.bg0)
call s:HL('palenightBg1', s:gb.bg1)
call s:HL('palenightBg2', s:gb.bg2)
call s:HL('palenightBg3', s:gb.bg3)
call s:HL('palenightBg4', s:gb.bg4)

" INSERT ALL BOLD HERE
call s:HL('palenightRed', s:gb.red)
call s:HL('palenightRedBold', s:gb.red, s:none, s:bold)
call s:HL('palenightGreen', s:gb.green)
call s:HL('palenightGreenBold', s:gb.faded_blue, s:none, s:bold)
call s:HL('palenightYellow', s:gb.yellow)
call s:HL('palenightYellowBold', s:gb.yellow, s:none, s:bold)
call s:HL('palenightBlue', s:gb.blue)
call s:HL('palenightBlueBold', s:gb.blue, s:none, s:bold)
call s:HL('palenightPurple', s:gb.purple)
call s:HL('palenightPurpleBold', s:gb.purple, s:none, s:bold)
call s:HL('palenightAqua', s:gb.aqua)
call s:HL('palenightAquaBold', s:gb.aqua, s:none, s:bold)
call s:HL('palenightOrange', s:gb.orange)
call s:HL('palenightOrangeBold', s:gb.orange, s:none, s:bold)

call s:HL('palenightRedSign', s:gb.red, s:sign_column, s:invert_signs)
call s:HL('palenightGreenSign', s:gb.green, s:sign_column, s:invert_signs)
call s:HL('palenightYellowSign', s:gb.yellow, s:sign_column, s:invert_signs)
call s:HL('palenightBlueSign', s:gb.blue, s:sign_column, s:invert_signs)
call s:HL('palenightPurpleSign', s:gb.purple, s:sign_column, s:invert_signs)
call s:HL('palenightAquaSign', s:gb.aqua, s:sign_column, s:invert_signs)
call s:HL('palenightOrangeSign', s:gb.orange, s:sign_column, s:invert_signs)

call s:HL('palenightRedUnderline', s:none, s:none, s:undercurl, s:gb.red)
call s:HL('palenightGreenUnderline', s:none, s:none, s:undercurl, s:gb.green)
call s:HL('palenightYellowUnderline', s:none, s:none, s:undercurl, s:gb.yellow)
call s:HL('palenightBlueUnderline', s:none, s:none, s:undercurl, s:gb.blue)
call s:HL('palenightPurpleUnderline', s:none, s:none, s:undercurl, s:gb.purple)
call s:HL('palenightAquaUnderline', s:none, s:none, s:undercurl, s:gb.aqua)
call s:HL('palenightOrangeUnderline', s:none, s:none, s:undercurl, s:gb.orange)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:gb.fg1, s:gb.bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/palenight/issues/7
if exists('v:vim_did_enter')
  let g:palenight_vim_did_enter = v:vim_did_enter
else
  augroup palenightVimEnter
    au!
    autocmd VimEnter * let g:palenight_vim_did_enter = 1
  augroup End
endif
if get(g:, 'palenight_vim_did_enter', 0)
  if s:is_dark
    set background=dark
  else
    set background=light
  endif
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine', s:none, s:cursorline)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:gb.bg4, s:gb.bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:tabline_sel, s:gb.bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:gb.bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:gb.blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:gb.yellow, s:cursorline)
endif

hi! link NonText palenightBg2
hi! link SpecialKey palenightFg4

call s:HL('Visual',    s:none,  s:gb.bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search', s:hls_highlight, s:gb.bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:gb.bg0, s:inverse)

call s:HL('QuickFixLine', s:gb.bg0, s:gb.yellow, s:bold)

call s:HL('Underlined', s:gb.blue, s:none, s:underline)

call s:HL('StatusLine',   s:gb.bg2, s:gb.fg1, s:inverse)
call s:HL('StatusLineNC', s:gb.bg1, s:gb.fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:gb.bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:gb.blue, s:gb.bg2, s:bold)

" Directory names, special names in listing
hi! link Directory palenightGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title palenightGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:gb.bg0, s:gb.red, s:bold)
" More prompt: -- More --
hi! link MoreMsg palenightYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg palenightYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question palenightOrangeBold
" Warning messages
hi! link WarningMsg palenightRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:gb.bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gb.gray, s:gb.bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gb.gray, s:gb.bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:palenight_improved_strings == 0
  hi! link Special palenightOrange
else
  call s:HL('Special', s:gb.orange, s:gb.bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gb.gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:none, s:bold . s:italic)
call s:HL('Error', s:gb.red, s:none, s:bold . s:inverse)

" Generic statement
hi! link Statement palenightRed
" if, then, else, endif, switch, etc.
hi! link Conditional palenightRed
" for, do, while, etc.
hi! link Repeat palenightRed
" case, default, etc.
hi! link Label palenightRed
" try, catch, throw
hi! link Exception palenightRed
" sizeof, "+", "*", etc.
call s:HL('Operator',  s:gb.orange, s:none, s:italicize_operators)
" Any other keyword
hi! link Keyword palenightRed

" Variable name
hi! link Identifier palenightBlue
" Function name
hi! link Function palenightGreenBold

" Generic preprocessor
hi! link PreProc palenightAqua
" Preprocessor #include
hi! link Include palenightAqua
" Preprocessor #define
hi! link Define palenightAqua
" Same as Define
hi! link Macro palenightAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit palenightAqua

" Generic constant
hi! link Constant palenightPurple
" Character constant: 'c', '/n'
hi! link Character palenightPurple
" String constant: "this is a string"
if g:palenight_improved_strings == 0
  call s:HL('String',  s:gb.green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:gb.fg1, s:gb.bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean palenightPurple
" Number constant: 234, 0xff
hi! link Number palenightPurple
" Floating point constant: 2.3e10
hi! link Float palenightPurple

" Generic type
hi! link Type palenightYellow
" static, register, volatile, etc
hi! link StorageClass palenightOrange
" struct, union, enum, etc.
hi! link Structure palenightAqua
" typedef
hi! link Typedef palenightYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:gb.fg1, s:gb.bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:gb.bg2, s:gb.blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:gb.bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:gb.bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:gb.red, s:gb.bg0, s:inverse)
call s:HL('DiffAdd',    s:gb.green, s:gb.bg0, s:inverse)
"call s:HL('DiffChange', s:gb.bg0, s:gb.blue)
"call s:HL('DiffText',   s:gb.bg0, s:gb.yellow)

" Alternative setting
call s:HL('DiffChange', s:gb.aqua, s:gb.bg0, s:inverse)
call s:HL('DiffText',   s:gb.yellow, s:gb.bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:palenight_improved_warnings == 0
    hi! link SpellCap palenightBlueUnderline
  else
    call s:HL('SpellCap',   s:gb.green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  hi! link SpellBad palenightRedUnderline
  " Wrong spelling for selected region
  hi! link SpellLocal palenightAquaUnderline
  " Rare word
  hi! link SpellRare palenightPurpleUnderline
endif

" }}}
" LSP: {{{

if has("nvim")
  hi! link DiagnosticError palenightRed
  hi! link DiagnosticSignError palenightRedSign
  hi! link DiagnosticUnderlineError palenightRedUnderline

  hi! link DiagnosticWarn palenightYellow
  hi! link DiagnosticSignWarn palenightYellowSign
  hi! link DiagnosticUnderlineWarn palenightYellowUnderline

  hi! link DiagnosticInfo palenightBlue
  hi! link DiagnosticSignInfo palenightBlueSign
  hi! link DiagnosticUnderlineInfo palenightBlueUnderline

  hi! link DiagnosticHint palenightAqua
  hi! link DiagnosticSignHint palenightAquaSign
  hi! link DiagnosticUnderlineHint palenightAquaUnderline

  hi! link LspReferenceText palenightYellowBold
  hi! link LspReferenceRead palenightYellowBold
  hi! link LspReferenceWrite palenightOrangeBold

  hi! link LspCodeLens palenightGray

  " Backward Compatibilty prior to (https://github.com/neovim/neovim/pull/15585)
  hi! link LspDiagnosticsDefaultError palenightRed
  hi! link LspDiagnosticsSignError palenightRedSign
  hi! link LspDiagnosticsUnderlineError palenightRedUnderline

  hi! link LspDiagnosticsDefaultWarning palenightYellow
  hi! link LspDiagnosticsSignWarning palenightYellowSign
  hi! link LspDiagnosticsUnderlineWarning palenightYellowUnderline

  hi! link LspDiagnosticsDefaultInformation palenightBlue
  hi! link LspDiagnosticsSignInformation palenightBlueSign
  hi! link LspDiagnosticsUnderlineInformation palenightBlueUnderline

  hi! link LspDiagnosticsDefaultHint palenightAqua
  hi! link LspDiagnosticsSignHint palenightAquaSign
  hi! link LspDiagnosticsUnderlineHint palenightAquaUnderline
endif

" }}}

" Treesitter: {{{

if has('nvim')
  " Highlight TSKeywordOperator as keywords
  " https://github.com/nvim-treesitter/nvim-treesitter/issues/447
  hi! link TSKeywordOperator palenightRed
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget palenightRedBold
hi! link EasyMotionTarget2First palenightYellowBold
hi! link EasyMotionTarget2Second palenightOrangeBold
hi! link EasyMotionShade palenightGray

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:palenight_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:gb.bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:gb.bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd palenightGreenSign
hi! link GitGutterChange palenightAquaSign
hi! link GitGutterDelete palenightRedSign
hi! link GitGutterChangeDelete palenightAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile palenightGreen
hi! link gitcommitDiscardedFile palenightRed

" }}}
" Signify: {{{

hi! link SignifySignAdd palenightGreenSign
hi! link SignifySignChange palenightAquaSign
hi! link SignifySignDelete palenightRedSign

" }}}
" gitsigns.nvim {{{
hi! link GitSignsAdd palenightGreenSign
hi! link GitSignsChange palenightAquaSign
hi! link GitSignsDelete palenightRedSign
" }}}
" Syntastic: {{{

hi! link SyntasticError palenightRedUnderline
hi! link SyntasticWarning palenightYellowUnderline

hi! link SyntasticErrorSign palenightRedSign
hi! link SyntasticWarningSign palenightYellowSign

" }}}
" Termdebug: {{{

call s:HL('debugPC', s:none, s:gb.faded_blue)
hi! link debugBreakpoint palenightRedSign

" }}}

" Signature: {{{
hi! link SignatureMarkText   palenightBlueSign
hi! link SignatureMarkerText palenightPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl palenightBlueSign
hi! link ShowMarksHLu palenightBlueSign
hi! link ShowMarksHLo palenightBlueSign
hi! link ShowMarksHLm palenightBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch palenightYellow
hi! link CtrlPNoEntries palenightRed
hi! link CtrlPPrtBase palenightBg2
hi! link CtrlPPrtCursor palenightBlue
hi! link CtrlPLinePre palenightBg2

call s:HL('CtrlPMode1', s:gb.blue, s:gb.bg2, s:bold)
call s:HL('CtrlPMode2', s:gb.bg0, s:gb.blue, s:bold)
call s:HL('CtrlPStats', s:gb.fg4, s:gb.bg2, s:bold)

" }}}
" FZF: {{{

let g:fzf_colors = {
      \ 'fg':      ['fg', 'palenightFg1'],
      \ 'bg':      ['fg', 'palenightBg0'],
      \ 'hl':      ['fg', 'palenightYellow'],
      \ 'fg+':     ['fg', 'palenightFg1'],
      \ 'bg+':     ['fg', 'palenightBg1'],
      \ 'hl+':     ['fg', 'palenightYellow'],
      \ 'info':    ['fg', 'palenightBlue'],
      \ 'prompt':  ['fg', 'palenightFg4'],
      \ 'pointer': ['fg', 'palenightBlue'],
      \ 'marker':  ['fg', 'palenightOrange'],
      \ 'spinner': ['fg', 'palenightYellow'],
      \ 'header':  ['fg', 'palenightBg3']
      \ }

call s:HL('Fzf1', s:gb.blue, s:gb.bg1)
call s:HL('Fzf2', s:gb.orange, s:gb.bg1)
call s:HL('Fzf3', s:gb.fg4, s:gb.bg1)

" }}}
" Startify: {{{

hi! link StartifyBracket palenightFg3
hi! link StartifyFile palenightFg1
hi! link StartifyNumber palenightBlue
hi! link StartifyPath palenightGray
hi! link StartifySlash palenightGray
hi! link StartifySection palenightYellow
hi! link StartifySpecial palenightBg2
hi! link StartifyHeader palenightOrange
hi! link StartifyFooter palenightBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:gb.bg4[0], s:gb.red[0], s:gb.green[0], s:gb.yellow[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.aqua[0], s:gb.fg4[0],
  \ s:gb.bg0[0], s:gb.red[0], s:gb.green[0], s:gb.orange[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.aqua[0], s:gb.fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:gb.bg0, s:gb.fg4)
call s:HL('BufTabLineActive', s:gb.fg4, s:gb.bg2)
call s:HL('BufTabLineHidden', s:gb.bg4, s:gb.bg1)
call s:HL('BufTabLineFill', s:gb.bg0, s:gb.bg0)

" }}}
" Asynchronous Lint Engine: {{{

hi! link ALEError palenightRedUnderline
hi! link ALEWarning palenightYellowUnderline
hi! link ALEInfo palenightBlueUnderline

hi! link ALEErrorSign palenightRedSign
hi! link ALEWarningSign palenightYellowSign
hi! link ALEInfoSign palenightBlueSign

hi! link ALEVirtualTextError palenightRed
hi! link ALEVirtualTextWarning palenightYellow
hi! link ALEVirtualTextInfo palenightBlue

" }}}
" Dirvish: {{{

hi! link DirvishPathTail palenightAqua
hi! link DirvishArg palenightYellow

" }}}
" Netrw: {{{

hi! link netrwDir palenightAqua
hi! link netrwClassify palenightAqua
hi! link netrwLink palenightGray
hi! link netrwSymLink palenightFg1
hi! link netrwExe palenightYellow
hi! link netrwComment palenightGray
hi! link netrwList palenightBlue
hi! link netrwHelpCmd palenightAqua
hi! link netrwCmdSep palenightFg3
hi! link netrwVersion palenightGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir palenightAqua
hi! link NERDTreeDirSlash palenightAqua

hi! link NERDTreeOpenable palenightOrange
hi! link NERDTreeClosable palenightOrange

hi! link NERDTreeFile palenightFg1
hi! link NERDTreeExecFile palenightYellow

hi! link NERDTreeUp palenightGray
hi! link NERDTreeCWD palenightGreen
hi! link NERDTreeHelp palenightFg1

hi! link NERDTreeToggleOn palenightGreen
hi! link NERDTreeToggleOff palenightRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:gb.bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign palenightRedSign
hi! link CocWarningSign palenightOrangeSign
hi! link CocInfoSign palenightBlueSign
hi! link CocHintSign palenightAquaSign
hi! link CocErrorFloat palenightRed
hi! link CocWarningFloat palenightOrange
hi! link CocInfoFloat palenightBlue
hi! link CocHintFloat palenightAqua
hi! link CocDiagnosticsError palenightRed
hi! link CocDiagnosticsWarning palenightOrange
hi! link CocDiagnosticsInfo palenightBlue
hi! link CocDiagnosticsHint palenightAqua

hi! link CocSelectedText palenightRed
hi! link CocCodeLens palenightGray
hi! link CocSearch palenightAqua

hi! link CocErrorHighlight palenightRedUnderline
hi! link CocWarningHighlight palenightOrangeUnderline
hi! link CocInfoHighlight palenightBlueUnderline
hi! link CocHintHighlight palenightAquaUnderline

" }}}
" Telescope.nvim: {{{
hi! link TelescopeNormal palenightFg1
hi! link TelescopeSelection palenightOrangeBold
hi! link TelescopeSelectionCaret palenightRed
hi! link TelescopeMultiSelection palenightGray
hi! link TelescopeBorder TelescopeNormal
hi! link TelescopePromptBorder TelescopeNormal
hi! link TelescopeResultsBorder TelescopeNormal
hi! link TelescopePreviewBorder TelescopeNormal
hi! link TelescopeMatching palenightBlue
hi! link TelescopePromptPrefix palenightRed
hi! link TelescopePrompt TelescopeNormal

" }}}
" nvim-cmp: {{{
hi! link CmpItemAbbr palenightFg0
hi! link CmpItemAbbrDeprecated palenightFg1
hi! link CmpItemAbbrMatch palenightBlueBold
hi! link CmpItemAbbrMatchFuzzy palenightBlueUnderline
hi! link CmpItemMenu palenightGray
hi! link CmpItemKindText palenightOrange
hi! link CmpItemKindMethod palenightBlue
hi! link CmpItemKindFunction palenightBlue
hi! link CmpItemKindConstructor palenightYellow
hi! link CmpItemKindField palenightBlue
hi! link CmpItemKindClass palenightYellow
hi! link CmpItemKindInterface palenightYellow
hi! link CmpItemKindModule palenightBlue
hi! link CmpItemKindProperty palenightBlue
hi! link CmpItemKindValue palenightOrange
hi! link CmpItemKindEnum palenightYellow
hi! link CmpItemKindKeyword palenightPurple
hi! link CmpItemKindSnippet palenightGreen
hi! link CmpItemKindFile palenightBlue
hi! link CmpItemKindEnumMember palenightAqua
hi! link CmpItemKindConstant palenightOrange
hi! link CmpItemKindStruct palenightYellow
hi! link CmpItemKindTypeParameter palenightYellow
"}}}
" Dashboard: {{{
hi! link DashboardHeader palenightYellowBold
hi! link DashboardCenter palenightGreen
hi! link DashboardCenterIcon palenightAqua
hi! link DashboardShortCut palenightBlue
hi! link DashboardFooter palenightPurple
" }}}
" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded palenightGreen
hi! link diffRemoved palenightRed
hi! link diffChanged palenightAqua

hi! link diffFile palenightOrange
hi! link diffNewFile palenightYellow

hi! link diffLine palenightBlue

" }}}
" Html: {{{

hi! link htmlTag palenightAquaBold
hi! link htmlEndTag palenightAquaBold

hi! link htmlTagName palenightBlue
hi! link htmlArg palenightOrange

hi! link htmlTagN palenightFg1
hi! link htmlSpecialTagName palenightBlue

call s:HL('htmlLink', s:gb.fg4, s:none, s:underline)

hi! link htmlSpecialChar palenightRed

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag palenightAquaBold
hi! link xmlEndTag palenightAquaBold
hi! link xmlTagName palenightBlue
hi! link xmlEqual palenightBlue
hi! link docbkKeyword palenightAquaBold

hi! link xmlDocTypeDecl palenightGray
hi! link xmlDocTypeKeyword palenightPurple
hi! link xmlCdataStart palenightGray
hi! link xmlCdataCdata palenightPurple
hi! link dtdFunction palenightGray
hi! link dtdTagName palenightPurple

hi! link xmlAttrib palenightOrange
hi! link xmlProcessingDelim palenightGray
hi! link dtdParamEntityPunct palenightGray
hi! link dtdParamEntityDPunct palenightGray
hi! link xmlAttribPunct palenightGray

hi! link xmlEntity palenightRed
hi! link xmlEntityPunct palenightRed
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:gb.fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation palenightOrange
hi! link vimBracket palenightOrange
hi! link vimMapModKey palenightOrange
hi! link vimFuncSID palenightFg3
hi! link vimSetSep palenightFg3
hi! link vimSep palenightFg3
hi! link vimContinue palenightFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword palenightBlue
hi! link clojureCond palenightOrange
hi! link clojureSpecial palenightOrange
hi! link clojureDefine palenightOrange

hi! link clojureFunc palenightYellow
hi! link clojureRepeat palenightYellow
hi! link clojureCharacter palenightAqua
hi! link clojureStringEscape palenightAqua
hi! link clojureException palenightRed

hi! link clojureRegexp palenightAqua
hi! link clojureRegexpEscape palenightAqua
call s:HL('clojureRegexpCharClass', s:gb.fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen palenightFg3
hi! link clojureAnonArg palenightYellow
hi! link clojureVariable palenightBlue
hi! link clojureMacro palenightOrange

hi! link clojureMeta palenightYellow
hi! link clojureDeref palenightYellow
hi! link clojureQuote palenightYellow
hi! link clojureUnquote palenightYellow

" }}}
" C: {{{

hi! link cOperator palenightPurple
hi! link cppOperator palenightPurple
hi! link cStructure palenightOrange

" }}}
" Python: {{{

hi! link pythonBuiltin palenightOrange
hi! link pythonBuiltinObj palenightOrange
hi! link pythonBuiltinFunc palenightOrange
hi! link pythonFunction palenightAqua
hi! link pythonDecorator palenightRed
hi! link pythonInclude palenightBlue
hi! link pythonImport palenightBlue
hi! link pythonRun palenightBlue
hi! link pythonCoding palenightBlue
hi! link pythonOperator palenightRed
hi! link pythonException palenightRed
hi! link pythonExceptions palenightPurple
hi! link pythonBoolean palenightPurple
hi! link pythonDot palenightFg3
hi! link pythonConditional palenightRed
hi! link pythonRepeat palenightRed
hi! link pythonDottedName palenightGreenBold

" }}}
" CSS: {{{

hi! link cssBraces palenightBlue
hi! link cssFunctionName palenightYellow
hi! link cssIdentifier palenightOrange
hi! link cssClassName palenightGreen
hi! link cssColor palenightBlue
hi! link cssSelectorOp palenightBlue
hi! link cssSelectorOp2 palenightBlue
hi! link cssImportant palenightGreen
hi! link cssVendor palenightFg1

hi! link cssTextProp palenightAqua
hi! link cssAnimationProp palenightAqua
hi! link cssUIProp palenightYellow
hi! link cssTransformProp palenightAqua
hi! link cssTransitionProp palenightAqua
hi! link cssPrintProp palenightAqua
hi! link cssPositioningProp palenightYellow
hi! link cssBoxProp palenightAqua
hi! link cssFontDescriptorProp palenightAqua
hi! link cssFlexibleBoxProp palenightAqua
hi! link cssBorderOutlineProp palenightAqua
hi! link cssBackgroundProp palenightAqua
hi! link cssMarginProp palenightAqua
hi! link cssListProp palenightAqua
hi! link cssTableProp palenightAqua
hi! link cssFontProp palenightAqua
hi! link cssPaddingProp palenightAqua
hi! link cssDimensionProp palenightAqua
hi! link cssRenderProp palenightAqua
hi! link cssColorProp palenightAqua
hi! link cssGeneratedContentProp palenightAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces palenightFg1
hi! link javaScriptFunction palenightAqua
hi! link javaScriptIdentifier palenightRed
hi! link javaScriptMember palenightBlue
hi! link javaScriptNumber palenightPurple
hi! link javaScriptNull palenightPurple
hi! link javaScriptParens palenightFg3

" }}}
" YAJS: {{{

hi! link javascriptImport palenightAqua
hi! link javascriptExport palenightAqua
hi! link javascriptClassKeyword palenightAqua
hi! link javascriptClassExtends palenightAqua
hi! link javascriptDefault palenightAqua

hi! link javascriptClassName palenightYellow
hi! link javascriptClassSuperName palenightYellow
hi! link javascriptGlobal palenightYellow

hi! link javascriptEndColons palenightFg1
hi! link javascriptFuncArg palenightFg1
hi! link javascriptGlobalMethod palenightFg1
hi! link javascriptNodeGlobal palenightFg1
hi! link javascriptBOMWindowProp palenightFg1
hi! link javascriptArrayMethod palenightFg1
hi! link javascriptArrayStaticMethod palenightFg1
hi! link javascriptCacheMethod palenightFg1
hi! link javascriptDateMethod palenightFg1
hi! link javascriptMathStaticMethod palenightFg1

" hi! link javascriptProp palenightFg1
hi! link javascriptURLUtilsProp palenightFg1
hi! link javascriptBOMNavigatorProp palenightFg1
hi! link javascriptDOMDocMethod palenightFg1
hi! link javascriptDOMDocProp palenightFg1
hi! link javascriptBOMLocationMethod palenightFg1
hi! link javascriptBOMWindowMethod palenightFg1
hi! link javascriptStringMethod palenightFg1

hi! link javascriptVariable palenightOrange
" hi! link javascriptVariable palenightRed
" hi! link javascriptIdentifier palenightOrange
" hi! link javascriptClassSuper palenightOrange
hi! link javascriptIdentifier palenightOrange
hi! link javascriptClassSuper palenightOrange

" hi! link javascriptFuncKeyword palenightOrange
" hi! link javascriptAsyncFunc palenightOrange
hi! link javascriptFuncKeyword palenightAqua
hi! link javascriptAsyncFunc palenightAqua
hi! link javascriptClassStatic palenightOrange

hi! link javascriptOperator palenightRed
hi! link javascriptForOperator palenightRed
hi! link javascriptYield palenightRed
hi! link javascriptExceptions palenightRed
hi! link javascriptMessage palenightRed

hi! link javascriptTemplateSB palenightAqua
hi! link javascriptTemplateSubstitution palenightFg1

" hi! link javascriptLabel palenightBlue
" hi! link javascriptObjectLabel palenightBlue
" hi! link javascriptPropertyName palenightBlue
hi! link javascriptLabel palenightFg1
hi! link javascriptObjectLabel palenightFg1
hi! link javascriptPropertyName palenightFg1

hi! link javascriptLogicSymbols palenightFg1
hi! link javascriptArrowFunc palenightYellow

hi! link javascriptDocParamName palenightFg4
hi! link javascriptDocTags palenightFg4
hi! link javascriptDocNotation palenightFg4
hi! link javascriptDocParamType palenightFg4
hi! link javascriptDocNamedParamType palenightFg4

hi! link javascriptBrackets palenightFg1
hi! link javascriptDOMElemAttrs palenightFg1
hi! link javascriptDOMEventMethod palenightFg1
hi! link javascriptDOMNodeMethod palenightFg1
hi! link javascriptDOMStorageMethod palenightFg1
hi! link javascriptHeadersMethod palenightFg1

hi! link javascriptAsyncFuncKeyword palenightRed
hi! link javascriptAwaitFuncKeyword palenightRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword palenightAqua
hi! link jsExtendsKeyword palenightAqua
hi! link jsExportDefault palenightAqua
hi! link jsTemplateBraces palenightAqua
hi! link jsGlobalNodeObjects palenightBlue
hi! link jsGlobalObjects palenightBlue
hi! link jsObjectKey palenightGreenBold
hi! link jsFunction palenightAqua
hi! link jsFuncCall palenightBlue
hi! link jsFuncParens palenightFg3
hi! link jsParens palenightFg3
hi! link jsNull palenightPurple
hi! link jsUndefined palenightPurple
hi! link jsClassDefinition palenightYellow
hi! link jsOperatorKeyword palenightRed

" }}}
" TypeScript: {{{

hi! link typescriptReserved palenightAqua
hi! link typescriptLabel palenightAqua
hi! link typescriptFuncKeyword palenightAqua
hi! link typescriptIdentifier palenightOrange
hi! link typescriptBraces palenightFg1
hi! link typescriptEndColons palenightFg1
hi! link typescriptDOMObjects palenightFg1
hi! link typescriptAjaxMethods palenightFg1
hi! link typescriptLogicSymbols palenightFg1
hi! link typescriptDocSeeTag Comment
hi! link typescriptDocParam Comment
hi! link typescriptDocTags vimCommentTitle
hi! link typescriptGlobalObjects palenightFg1
hi! link typescriptParens palenightFg3
hi! link typescriptOpSymbols palenightFg3
hi! link typescriptHtmlElemProperties palenightFg1
hi! link typescriptNull palenightPurple
hi! link typescriptInterpolationDelimiter palenightAqua

" }}}
" JSX: maxmellon/vim-jsx-pretty: {{{

hi! link jsxTagName palenightAqua
hi! link jsxComponentName palenightGreen
hi! link jsxCloseString palenightFg4
hi! link jsxAttrib palenightYellow
hi! link jsxEqual palenightAqua

"}}}
" PureScript: {{{

hi! link purescriptModuleKeyword palenightAqua
hi! link purescriptModuleName palenightFg1
hi! link purescriptWhere palenightAqua
hi! link purescriptDelimiter palenightFg4
hi! link purescriptType palenightFg1
hi! link purescriptImportKeyword palenightAqua
hi! link purescriptHidingKeyword palenightAqua
hi! link purescriptAsKeyword palenightAqua
hi! link purescriptStructure palenightAqua
hi! link purescriptOperator palenightBlue

hi! link purescriptTypeVar palenightFg1
hi! link purescriptConstructor palenightFg1
hi! link purescriptFunction palenightFg1
hi! link purescriptConditional palenightOrange
hi! link purescriptBacktick palenightOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp palenightFg3
hi! link coffeeSpecialOp palenightFg3
hi! link coffeeCurly palenightOrange
hi! link coffeeParen palenightFg3
hi! link coffeeBracket palenightOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter palenightGreen
hi! link rubyInterpolationDelimiter palenightAqua
hi! link rubyDefinedOperator rubyKeyword

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier palenightRed
hi! link objcDirective palenightBlue

" }}}
" Go: {{{

hi! link goDirective palenightAqua
hi! link goConstants palenightPurple
hi! link goDeclaration palenightRed
hi! link goDeclType palenightBlue
hi! link goBuiltins palenightOrange

" }}}
" Lua: {{{

hi! link luaIn palenightRed
hi! link luaFunction palenightAqua
hi! link luaTable palenightOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp palenightFg3
hi! link moonExtendedOp palenightFg3
hi! link moonFunction palenightFg3
hi! link moonObject palenightYellow

" }}}
" Java: {{{

hi! link javaAnnotation palenightBlue
hi! link javaDocTags palenightAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen palenightFg3
hi! link javaParen1 palenightFg3
hi! link javaParen2 palenightFg3
hi! link javaParen3 palenightFg3
hi! link javaParen4 palenightFg3
hi! link javaParen5 palenightFg3
hi! link javaOperator palenightOrange

hi! link javaVarArg palenightGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter palenightGreen
hi! link elixirInterpolationDelimiter palenightAqua

hi! link elixirModuleDeclaration palenightYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition palenightFg1
hi! link scalaCaseFollowing palenightFg1
hi! link scalaCapitalWord palenightFg1
hi! link scalaTypeExtension palenightFg1

hi! link scalaKeyword palenightRed
hi! link scalaKeywordModifier palenightRed

hi! link scalaSpecial palenightAqua
hi! link scalaOperator palenightFg1

hi! link scalaTypeDeclaration palenightYellow
hi! link scalaTypeTypePostDeclaration palenightYellow

hi! link scalaInstanceDeclaration palenightFg1
hi! link scalaInterpolation palenightAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)
call s:HL('markdownBold', s:fg3, s:none, s:bold)
call s:HL('markdownBoldItalic', s:fg3, s:none, s:bold . s:italic)

hi! link markdownH1 palenightGreenBold
hi! link markdownH2 palenightGreenBold
hi! link markdownH3 palenightYellowBold
hi! link markdownH4 palenightYellowBold
hi! link markdownH5 palenightYellow
hi! link markdownH6 palenightYellow

hi! link markdownCode palenightAqua
hi! link markdownCodeBlock palenightAqua
hi! link markdownCodeDelimiter palenightAqua

hi! link markdownBlockquote palenightGray
hi! link markdownListMarker palenightGray
hi! link markdownOrderedListMarker palenightGray
hi! link markdownRule palenightGray
hi! link markdownHeadingRule palenightGray

hi! link markdownUrlDelimiter palenightFg3
hi! link markdownLinkDelimiter palenightFg3
hi! link markdownLinkTextDelimiter palenightFg3

hi! link markdownHeadingDelimiter palenightOrange
hi! link markdownUrl palenightPurple
hi! link markdownUrlTitleDelimiter palenightGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

hi! link haskellType palenightBlue
hi! link haskellIdentifier palenightAqua
hi! link haskellSeparator palenightFg4
hi! link haskellDelimiter palenightOrange
hi! link haskellOperators palenightPurple

hi! link haskellBacktick palenightOrange
hi! link haskellStatement palenightPurple
hi! link haskellConditional palenightPurple

hi! link haskellLet palenightRed
hi! link haskellDefault palenightRed
hi! link haskellWhere palenightRed
hi! link haskellBottom palenightRedBold
hi! link haskellImportKeywords palenightPurpleBold
hi! link haskellDeclKeyword palenightOrange
hi! link haskellDecl palenightOrange
hi! link haskellDeriving palenightPurple
hi! link haskellAssocType palenightAqua

hi! link haskellNumber palenightAqua
hi! link haskellPragma palenightRedBold

hi! link haskellTH palenightAquaBold
hi! link haskellForeignKeywords palenightGreen
hi! link haskellKeyword palenightRed
hi! link haskellFloat palenightAqua
hi! link haskellInfix palenightPurple
hi! link haskellQuote palenightGreenBold
hi! link haskellShebang palenightYellowBold
hi! link haskellLiquid palenightPurpleBold
hi! link haskellQuasiQuoted palenightBlueBold
hi! link haskellRecursiveDo palenightPurple
hi! link haskellQuotedType palenightRed
hi! link haskellPreProc palenightFg4
hi! link haskellTypeRoles palenightRedBold
hi! link haskellTypeForall palenightRed
hi! link haskellPatternKeyword palenightBlue

" }}}
" Json: {{{

hi! link jsonKeyword palenightGreen
hi! link jsonQuote palenightGreen
hi! link jsonBraces palenightFg1
hi! link jsonString palenightFg1

" }}}
" Mail: {{{

" Override some defaults defined by mail.vim
" mail quoted text
hi! link mailQuoted1 palenightAqua
hi! link mailQuoted2 palenightPurple
hi! link mailQuoted3 palenightYellow
hi! link mailQuoted4 palenightGreen
hi! link mailQuoted5 palenightRed
hi! link mailQuoted6 palenightOrange

hi! link mailSignature Comment

" }}}
" C#: {{{

hi! link csBraces palenightFg1
hi! link csEndColon palenightFg1
hi! link csLogicSymbols palenightFg1
hi! link csParens palenightFg3
hi! link csOpSymbols palenightFg3
hi! link csInterpolationDelimiter palenightFg3
hi! link csInterpolationAlignDel palenightAquaBold
hi! link csInterpolationFormat palenightAqua
hi! link csInterpolationFormatDel palenightAquaBold

" }}}
" Rust: {{{

hi! link rustSigil palenightOrange
hi! link rustEscape palenightAqua
hi! link rustStringContinuation palenightAqua
hi! link rustEnum palenightAqua
hi! link rustStructure palenightAqua
hi! link rustModPathSep palenightFg2
hi! link rustCommentLineDoc Comment
hi! link rustDefault palenightAqua

" }}}
" Ocaml: {{{

hi! link ocamlOperator palenightFg1
hi! link ocamlKeyChar palenightOrange
hi! link ocamlArrow palenightOrange
hi! link ocamlInfixOpKeyword palenightRed
hi! link ocamlConstructor palenightOrange

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

" function! palenightHlsShowCursor()
"   call s:HL('Cursor', s:bg0, s:hls_cursor)
" endfunction

" function! palenightHlsHideCursor()
"   call s:HL('Cursor', s:none, s:none, s:inverse)
" endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker: