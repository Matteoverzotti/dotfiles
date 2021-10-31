call plug#begin()

Plug 'joshdick/onedark.vim'
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1

Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

source ~/.dotfiles/.vim/general.vim
source ~/.dotfiles/.vim/coc.vim
