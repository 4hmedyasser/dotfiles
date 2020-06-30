
let g:netrw_banner=0
let g:netrw_winsize=20
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



" Set tabs to 4 spaces
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=0
set tabstop=8



set clipboard^=unnamed,unnamedplus
set completeopt=longest,menuone
syntax on
set cursorline
set cursorcolumn
set number
set hlsearch
set autochdir
filetype plugin on
filetype plugin indent on
set autoindent
set smartindent
set cindent
set t_Co=256
colorscheme gruvbox
set background=dark
set whichwrap+=<,>,h,l,[,]
inoremap <C-@> <C-p>
" Shift + Tab: reverse tab
inoremap <S-Tab> <C-d>



" Bracket auto close
inoremap ` ``<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap < <><left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O 

" Don't type another closing character when one is already present
inoremap ` <c-r>=QuoteDelim('`')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap > <c-r>=ClosePair('>')<CR>
inoremap } <c-r>=CloseBracket()<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endf

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        "Inserting a quoted quotation mark into the string
        return a:char
    elseif line[col - 1] == a:char
        "Escaping out of the string
        return "\<Right>"
    else
        "Starting a string
        return a:char.a:char."\<Esc>i"
    endif
endf
