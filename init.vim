:call plug#begin('~/.config/nvim')
Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-jedi'
" Plug 'davidhalter/jedi-vim'
Plug 'neovim/nvim-lspconfig'
Plug 'Shougo/deoplete-lsp'
Plug 'Chiel92/vim-autoformat'
Plug 'jiangmiao/auto-pairs'


:call plug#end()

:set number
:filetype on
:set autoindent
:set smartindent

set tags=tags;

autocmd Filetype cxx setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab cindent
autocmd Filetype cpp setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab cindent
autocmd Filetype h setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab cindent

autocmd Filetype perl setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab
autocmd Filetype perl set iskeyword+=:
autocmd Filetype python setlocal ts=4 softtabstop=4 shiftwidth=4 expandtab formatprg=autopep8\ -
autocmd Filetype vue setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab 
autocmd Filetype json setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab 

command Autoformat gggqG

nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C

nnoremap zz :update <CR>


nnoremap <S-Tab> <<
nnoremap <Tab> >>
inoremap <S-Tab> <C-d>

" Cleans up trailing whitespace
:nnoremap <silent> <C-K> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
""source cscope_maps.vim

let g:deoplete#enable_at_startup = 1
let g:deoplete#handler_enabled = 1
let g:formatterpath=['autopep8']
luafile $HOME/.config/nvim/lua/init.lua

