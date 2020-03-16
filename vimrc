


let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_browse_split=4
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



augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :call ToggleNetrw()
	autocmd VimEnter * wincmd p
augroup END



autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif



let g:NetrwIsOpen=0



set clipboard=unnamedplus
set autoindent
set smartindent
set cindent
syntax on
filetype plugin indent on
filetype plugin on
colorscheme gotham
set background=dark
set number
set whichwrap+=<,>,h,l,[,]
inoremap <S-Tab> <C-d>
inoremap <C-@> <C-p>
inoremap ` ``<left>
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap < <><left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O 
