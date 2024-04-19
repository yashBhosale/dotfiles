:set number
:filetype on
:set autoindent
:set smartindent

set tags=tags;

setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab cindent
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

nnoremap <leader>o <cmd>CHADopen<cr>

nnoremap <S-Tab> <<
nnoremap <Tab> >>
inoremap <S-Tab> <C-d>

" Cleans up trailing whitespace
:nnoremap <silent> <C-K> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
""source cscope_maps.vim

let g:formatterpath=['autopep8']
luafile $HOME/.config/nvim/lua/init.lua
colorscheme tokyonight

function! CloseChadTree()
    let l:bufs = filter(range(1, bufnr('$')), 'getbufvar(v:val, "&filetype") == "CHADTree"')
    for l:buf in l:bufs
        :execute "bdelete " . l:buf
    endfor
endfunction

nnoremap <leader>O <cmd> :call CloseChadTree()<CR>
map <c-n> <c-w><
map <c-m> <c-w>>
map + <c-w>+
map - <c-w>-
