""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(stdpath('data') . '/plugged')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    Plug 'bling/vim-airline'
    Plug 'ivanov/vim-ipython'
    Plug 'junegunn/fzf.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/syntastic'
    Plug 'morhetz/gruvbox'
    Plug 'Shougo/deoplete.nvim'
    Plug 'sk1418/Join'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-surround'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug '/usr/local/opt/fzf/'
    Plug 'zchee/deoplete-jedi'
call plug#end()

syntax enable
set smartindent                         " Enable smart indent
set incsearch                           " Incremental search
set shiftwidth=4                        " Enable shift width in 4 spaces
set tabstop=4 softtabstop=4             " Tab is 4 spaces
set expandtab                           " Expand the tab
set smartcase                           " case senstiive searching
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
set foldmethod=marker
set ma
set encoding=utf-8
let g:airline_powerline_fonts = 1 "for ryanoasis/devicons to work if using airline
let g:python3_host_prog="/home/neovim/.local/share/vendorvenv/python3_neovim_provider/bin/python"
let g:slime_target = "neovim"
set path+=**

" function SlimeOverrideConfig()
"   let b:slime_config = {}
"   echo "job id: "b:terminal_job_id
"   let b:slime_config["jobid"] = b:terminal_job_id 
" endfunction

" autocmd VimEnter * call SlimeOverrideConfig()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                    Colors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme gruvbox 
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   Deoplete-Jedi
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 0

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

" Press * to search for a term under the cursor then press a key below to
" replace all instance of it in the current file
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
" same as above but for selected text 
xnoremap <Leader>r :%s///g<Left><Left>
xnoremap <Leader>rc :%s///gc<Left><Left><Left>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"disable python2
let g:loaded_python_provider = 1
let python_highlight_all = 1
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

nnoremap <leader>v :e $MYVIMRC<cr>
nnoremap <silent> <leader>f :FZF<cr>
nnoremap <C-p> :Files<CR>
nnoremap <leader>F :Locate /<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>l :Lines<CR>
nnoremap <leader><leader>l :BLines<CR>
nnoremap <C-f> :Rg 
nnoremap <C-Tab> :Windows<CR>
"move the lines up or down
nnoremap <C-j> :m+<cr>
nnoremap <C-k> :m-2<cr>
nmap <leader>s <Plug>SlimeSendCell
