call plug#begin()

Plug 'joshdick/onedark.vim'
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1

Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'

call plug#end()

source ~/.dotfiles/vim/general.vim

" set autoindent
" set smartindent
" set tabstop=2
" set shiftwidth=2
" set nowrap
" set backspace=2
" set number
" set smarttab
" set expandtab
" set viminfo='100,<1000,s100,h
" set nu rnu
" 
" " Syntax / Colorscheme
" syntax on
" colorscheme kuroi
" 
" hi Normal guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE ctermfg=NONE
" hi NonText guibg=NONE ctermbg=NONE
" hi LineNr ctermfg=yellow
" 
" " Folding
" set foldmethod=syntax
" set foldnestmax=10
" set nofoldenable
" set foldlevel=2
" autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
" autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" 
" " Compile / Run
" " For normal tasks
" autocmd filetype cpp nnoremap <F8> :!g++ -Wall -fsanitize=address,undefined,signed-integer-overflow -DBLAT -O2 -std=c++17 % -o %:r<Enter>
" ""autocmd filetype cpp nnoremap <F8> :!g++ -Wall -DBLAT -O2 -std=c++17 % -o %:r<Enter>
" 
" 
" " For communication tasks
" autocmd filetype cpp nnoremap <F7> :!g++ -Wall -fsanitize=address,undefined,signed-integer-overflow -O2 -std=c++17 % grader.cpp -o %:r<Enter>
" 
" autocmd filetype cpp nnoremap <F9> :!./%:r<Enter>
