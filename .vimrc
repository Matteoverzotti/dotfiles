call plug#begin()

Plug 'joshdick/onedark.vim'
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1

Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'

Plug 'vimsence/vimsence'

call plug#end()

source ~/.dotfiles/.vim/general.vim
source ~/.dotfiles/.vim/coc.vim

