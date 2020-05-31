""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   General 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
set mouse=a
set termguicolors
set background=dark
set number
set relativenumber
set hidden
set clipboard=unnamed
set cursorline
set showmatch
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=99
set fileformat=unix
set encoding=utf-8
let g:airline_powerline_fonts = 1 "for ryanoasis/devicons to work if using airline
let g:python3_host_prog="/home/neovim/.local/share/vendorvenv/python3_neovim_provider/bin/python"
let g:slime_target = "neovim"
set path+=**

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme seoul256
set background=dark
let g:seoul256_background = 233 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Deoplete-Jedi 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 0
"inoremap <expr><C-n> deoplete#mappings#manual_complete()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Stripwhite() 
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e
	call cursor(l,c)
endfun
"strip trailing white spaces

let g:loaded_python_provider = 1 
let python_highlight_all = 1
set foldmethod=marker
noremap Y y$ 
"this is for y$ to yank to end
nmap <S-Enter> O<Esc>j
map <F2> i<CR>
nmap <CR> o<Esc>k
map :ntree :NERDTree<CR>
nmap <F6> :NERDTreeToggle<CR>
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>
"opens NERDtree automatically when vim starts up
" autocmd vimenter * NERDTree
set wrap
"changes indentation for other file types
au BufNewFile,BufRead *{js,html,css}
		\ set tabstop=2
		\| colorscheme monokai
		\| set softtabstop=2
		\| set shiftwidth=2
		\| set expandtab
		\| set autoindent

au BufNewFile,BufRead *.py 
		\ set tabstop=4
		\| set autoindent
		\| set shiftwidth=4
		\| set expandtab
		\| set fileformat=unix

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Jupyter IPython 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ipy_celldef = '^##'
let g:nvim_ipy_perform_mappings = 0
map <silent><c-s> <Plug>(IPy-Run)
map <silent><leader>rc <Plug>(IPy-RunCell)	
map <silent><leader>rr <Plug>(IPy-RunAll)
map <silent><leader>xx <Plug>(IPy-Interrupt)
map <silent><leader>tt <Plug>(IPy-Terminate)


nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap <silent> <leader>f :FZF<cr>
"move the lines up or down 
nnoremap <C-j> :m+<cr>
nnoremap <C-k> :m-2<cr>
