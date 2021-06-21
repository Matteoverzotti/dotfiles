call plug#begin()

Plug 'joshdick/onedark.vim'
let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1

Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'mhinz/vim-startify'
Plug 'JamshedVesuna/vim-markdown-preview'

call plug#end()

source ~/.config/nvim/modules/general.vim
source ~/.config/nvim/plug-config/coc.vim
