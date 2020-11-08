colorscheme slate
let g:airline_theme='murmur'

let g:netrw_banner=0
let g:netrw_winsize=10
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3



function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction



" Split screen
function! OpenBeside()
    :normal v
    let g:path=expand('%:p')
    :q!
    execute 'belowright vnew' g:path
    :normal <C-l>
endfunction


function! OpenBelow()
    :normal v
    let g:path=expand('%:p')
    :q!
    execute 'belowright new' g:path
    :normal <C-l>
endfunction
""""" END Split screen



function! NetrwMappings()
    noremap <silent> <C-f> :call ToggleNetrw()<CR>
    " Shift + v: Split Vertically
    noremap <buffer> V :call OpenBeside()<cr>
    " Shift + h: Split Horizontally
    noremap <buffer> H :call OpenBelow()<cr>
endfunction



augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwMappings()
augroup END



augroup ProjectDrawer
    autocmd!
    if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
        silent exe "bwipeout " . bufnr("$")
        exe 'cd '.argv()[0]
        autocmd VimEnter * :call ToggleNetrw()
    else
        autocmd VimEnter * :call ToggleNetrw()
        autocmd VimEnter * wincmd p
    endif
augroup END



" Quit netrw with the file buffer
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif



let g:NetrwIsOpen=0



" Mouse Visual Mode
if has('mouse')
    if &term =~ 'xterm'
        set mouse=a
    else
        set mouse=nvi
    endif
endif



set clipboard^=unnamed,unnamedplus
set number
syntax on
set cursorline
set cursorcolumn
highlight CursorColumn cterm=NONE term=NONE ctermbg=black guibg=NONE
highlight CursorLine cterm=NONE term=NONE ctermbg=black guibg=NONE
highlight CursorLineNR cterm=NONE term=NONE ctermbg=black guibg=NONE
" Highlight all search pattern matches
set hlsearch
nnoremap <CR> :nohlsearch<CR><CR>

" Ctrl + a: select all
noremap <C-a> ggVG

set autochdir
set autoindent
filetype plugin indent on
" Autocompletion
set completeopt=longest,menuone
inoremap <C-@> <C-n><Down>

" Automatically wrap left and right
set whichwrap+=<,>,h,l,[,]

" Shift + Tab: reverse tab
inoremap <S-Tab> <C-d>

" Ctrl + Backspace: delete word
inoremap <C-h> <C-w>



" Automatically append closing characters - Making Parenthesis And Brackets Handling Easier
inoremap " ""<Esc>i
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<ESC>O
inoremap "" ""<Esc>i
inoremap () ()<Esc>i
inoremap [] []<Esc>i
inoremap {} {}<Esc>i
inoremap {}<CR> {<CR>}<ESC>O



" Set tabs to 4 spaces
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=0
set tabstop=8
