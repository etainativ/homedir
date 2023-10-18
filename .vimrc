set nocompatible              " be iMproved, required
filetype off

set t_Co=256
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugin manager
Plugin 'VundleVim/Vundle.vim'

" Use release branch (recommend)
Plugin 'neoclide/coc.nvim'

"taglist management?
" Plugin 'ludovicchabant/vim-gutentags.git'

" Fast searcg for expression in code (Ctrl+f f)
Plugin 'dyng/ctrlsf.vim'

" file finder with fuzzy logic, very slow find replacement
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() }}

" Tmux line
Plugin 'edkolev/tmuxline.vim'

" running clang-format
Plugin 'rhysd/vim-clang-format'

" error checker
" Plugin 'vim-syntastic/syntastic'

" GIT stuff 
Plugin 'tpope/vim-fugitive'

" nive status bar
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" File explorer
Plugin 'scrooloose/nerdtree'

" brief review of tags
Plugin 'preservim/tagbar'
" Plugin 'yegappan/taglist'

" Plugin 'rking/ag.vim'
" Plugin 'w0rp/ale'
" Bundle 'nathanalderson/yang.vim'

Plugin 'github/copilot.vim'
call vundle#end()

filetype plugin indent on
syntax on

" Tab stuff "
set backspace=2
set laststatus=2

" color correction
set background=dark

" annoying white spaces "
highlight BadWhitespace ctermbg=red guibg=darkred
match BadWhitespace /\s\+$/

" encoding "
set encoding=utf-8

" Search lock on the first match "
set incsearch

" Relative line numbering "
set relativenumber
set number

" Line numbers cologing "
highlight CursorLineNr term=bold
highlight CursorLineNr ctermfg=Grey
highlight CursorLineNr ctermbg=NONE
highlight CursorLineNr gui=NONE
highlight CursorLineNr guifg=Grey
highlight CursorLineNr guibg=NONE
highlight LineNr term=bold
highlight LineNr ctermfg=DarkGrey
highlight LineNr ctermbg=NONE
highlight LineNr gui=NONE
highlight LineNr guifg=DarkGrey
highlight LineNr guibg=NONE

" 80 char marker
set colorcolumn=80
highlight ColorColumn ctermbg=darkgray

" mapping pane move/resize shortcut "
map <C-h> <C-w>h	" move to left pane
map <C-k> <C-w>j	" move to upper pane
map <C-j> <C-w>k	" move to lower pane
map <C-l> <C-w>l	" move to right pane


" Settings CoC autocomplete menues
hi CocFloating ctermbg=0 guibg=#e4e4e4


" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

" update cscope "
    function! UpdateCscope()
    	silent !echo "\nLocating files"
    	silent !find . -name '*.c' -o -name "*.h" -o -name "*.py" > cscope.files
    	silent !echo "Rebuilding cscope db..."
    	silent !cscope -b -q
    	silent !echo "Rebuilding ctags db..."
    	silent !ctags -L cscope.files
    	:redraw!
    	:cs reset
    endfunction
    map <F5> :call UpdateCscope()<CR>

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " remove and cscope databases
    cs kill -1

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

    nmap <C-@><C-@>s :tabnew %<CR>g:cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :tabnew %<CR>g:cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :tabnew %<CR>g:cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :tabnew %<CR>g:cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :tabnew %<CR>g:cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :tabnew %<CR>g:cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-@><C-@>i :tabnew %<CR>g:cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-@><C-@>d :tabnew %<CR>g:cs find d <C-R>=expand("<cword>")<CR><CR>


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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               FileTypes                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType c setlocal shiftwidth=4
autocmd FileType cpp setlocal shiftwidth=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               NERDTree                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.pyc', '\~$']
let g:NERDTreeChDirMode=2
let g:NERDTreeMinimalUI=1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               Airline                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let g:airline_theme = 'peaksea'
let g:airline_theme = 'etai'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z=airline#section#create(['%l/%L', ' : ','%c'])
let g:airline_mode_map = {
  \ '__'     : '-',
  \ 'c'      : 'C',
  \ 'i'      : 'I',
  \ 'ic'     : 'I',
  \ 'ix'     : 'I',
  \ 'n'      : 'N',
  \ 'multi'  : 'M',
  \ 'ni'     : 'N',
  \ 'no'     : 'N',
  \ 'R'      : 'R',
  \ 'Rv'     : 'R',
  \ 's'      : 'S',
  \ 'S'      : 'S',
  \ ''     : 'S',
  \ 't'      : 'T',
  \ 'v'      : 'V',
  \ 'V'      : 'V',
  \ ''     : 'V',
  \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                syntastic                                "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_error_symbol = 'X'
let g:syntastic_warning_symbol = '?'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--select=F,C9 --max-complexity=10'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              CtrlSF	                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_search_mode = 'async'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              FZF	                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" I got used to Ctrlp so thats why thus shortcut
map <C-P> :Files<CR>
map <F3> :Tags<CR>
let $FZF_DEFAULT_COMMAND = 'ag -u --ignore .git -l ""'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Coc            	                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <c-@> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Tagbar                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F8> :TagbarToggle<CR>

