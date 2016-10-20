" Use Vim defaults instead of 100% vi compatibility
" This must be first, because it changes other options as side effect
set nocompatible

"-------------------------------------------------------------------------------
" Auto highlight current word when idle
" From: http://vim.wikia.com/wiki/Auto_highlight_current_word_when_idle
"-------------------------------------------------------------------------------

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\<'.expand('<cword>').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

"-------------------------------------------------------------------------------
" Automatic Saving/Loaging folds and others view settings.
" From: http://www.linux.com/archive/feature/114138
" (the code is from the final part of the article and the first comment.)
"-------------------------------------------------------------------------------

" automatic save of the view configuration of a file. ex: the folds on a file
au BufWinLeave ?* mkview
" automatic load of the view configuration of a file. ex: the folds on a file
au BufWinEnter ?* silent loadview

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSCOPE settings for vim           
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" This file contains some boilerplate settings for vim's cscope interface,
" plus some keyboard mappings that I've found useful.
"
" USAGE: 
" -- vim 6:     Stick this file in your ~/.vim/plugin directory (or in a
"               'plugin' directory in some other directory that is in your
"               'runtimepath'.
"
" -- vim 5:     Stick this file somewhere and 'source cscope.vim' it from
"               your ~/.vimrc file (or cut and paste it into your .vimrc).
"
" NOTE: 
" These key maps use multiple keystrokes (2 or 3 keys).  If you find that vim
" keeps timing you out before you can complete them, try changing your timeout
" settings, as explained below.
"
" Happy cscoping,
"
" Jason Duell       jduell@alumni.princeton.edu     2002/3/7
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim... 
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>	


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>	

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>	
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>	


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>	
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>	
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif

"-------------------------------------------------------------------------------
" RAONI's session
"-------------------------------------------------------------------------------

" more powerful backspacing
set backspace=indent,eol,start

" keep 1000 lines of command line history. Yea, 1k because i like history.
set history=1000

" show the cursor position all the time. It also show more informations like
" line & column of the cursor
set ruler

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

" set color terminal capacity. We are forcing 8 colors because in archlinux vim
" is too smart and see my xterm as 256 capable terminal em as soon we do anything
" in vim it changes the color but it is kind of ugly because the theme is for 8
" colors. In Debian there is this variant with 16 colors, we must test someday.
set t_Co=8

" column with line number
set number

" don't use mouse
set mouse=""

" set fold column & folded lines color to red on black
highlight CustomFoldColor term=italic cterm=NONE ctermfg=DarkCyan ctermbg=NONE gui=italic guifg=DarkCyan guibg=NONE
highlight! link FoldColumn CustomFoldColor
highlight! link Folded     CustomFoldColor

" set fold column visible with width of 2
set foldcolumn=2

" set status line for the current buffer window to better discern the active
" window in split windows. 
hi StatusLine ctermfg=DarkYellow

" c syntax optionals: GNU gcc specific items
let c_gnu = 1
" trailing white space and spaces before a <Tab>
let c_space_errors = 1
" Show partial command (as you type) in the last line of the screen
set showcmd

" better "go back the last jump" because in my keyboard configuration in order
" to type '' one have to press '<Space>'<Space>, and 4 keystrokes is too much.
" Since pressing '' result in ´, we are mapping  this to the jump back.
map ´ ''

" highlight for white spaces at the end of lines. It will probably be overight
" by the syntax highlight for the files, but is here as a reminder
syntax match WhiteSpaceEOL excludenl "\s\+$"
highlight link WhiteSpaceEOL Error

" Map for easy toggle of wrap text.
map <silent> <F5> :set wrap!<cr>

" ----------------------------------
" Grogfx's section
" ----------------------------------

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
execute pathogen#infect()
execute pathogen#helptags()

syntax on
filetype plugin indent on
colors desert
set tabstop=2
set shiftwidth=2
set expandtab
set showmatch     " Briefly jump and show the matching bracket when inserting one.
set incsearch     " Highlight matching pattern while typing the search command
set colorcolumn=120                                                            
set ignorecase
set smartcase
highlight ColorColumn ctermbg=darkgray

"Change indentation for c files
autocmd FileType c setlocal tabstop=8

"Enables yang's syntax
au BufRead,BufNewFile *.yang setfiletype yang

" Resizing a window split
"map <C-left> <C-w><
"map <C-up> <C-w>-
"map <C-down> <C-w>+
"map <C-right> <C-w>>

" Easy window navigation
"map <S-left> <C-w>h
"map <S-down> <C-w>j
"map <S-up> <C-w>k
"map <S-right> <C-w>l

" Stop using arrows!!!!!
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

"Ctrl-p settings
" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0
" Search from current directory instead of project root
let g:ctrlp_working_path_mode = 0
" If ag is available use it as filename list generator instead of 'find'
if executable("ag")
	set grepprg=ag\ --nogroup\ --nocolor
	let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif
" PyMatcher for CtrlP
if !has('python')
	echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
	let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
" Ignore these directories
 set wildignore+=./build
 set wildignore+=./refs

"clang-format keybinds
map <C-K> :pyf /home/gmartins/bin/clang-format.py<cr>
imap <C-K> <c-o>:pyf /home/gmartins/bin/clang-format.py<cr>

"highlight ifdefs
syn region MySkip contained start="^\s*#\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*#\s*endif\>" contains=MySkip
let g:CommentDefines = ""
hi link MyCommentOut2 MyCommentOut
hi link MySkip MyCommentOut
hi link MyCommentOut Comment
map <silent> ,a :call AddCommentDefine()<CR>
map <silent> ,x :call ClearCommentDefine()<CR>
function! AddCommentDefine()
  let g:CommentDefines = "\\(" . expand("<cword>") . "\\)"
  syn clear MyCommentOut
  syn clear MyCommentOut2
  exe 'syn region MyCommentOut start="^\s*#\s*ifdef\s\+' . g:CommentDefines . '\>" end=".\|$" contains=MyCommentOut2'
  exe 'syn region MyCommentOut2 contained start="' . g:CommentDefines . '" end="^\s*#\s*\(endif\>\|else\>\|elif\>\)" contains=MySkip'
endfunction
function! ClearCommentDefine()
  let g:ClearCommentDefine = ""
  syn clear MyCommentOut
  syn clear MyCommentOut2
endfunction
