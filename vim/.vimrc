if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" still active
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
" Plug 'sheerun/vim-polyglot'
" Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'skywind3000/gutentags_plus'
" Plug 'eliba2/vim-node-inspect'
" Plug 'airblade/vim-gitgutter'
" Plug 'arcticicestudio/nord-vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'hoob3rt/lualine.nvim'
Plug 'tomarrell/vim-npr'
Plug 'SmiteshP/nvim-navic'
Plug 'MunifTanjim/nui.nvim'
Plug 'prisma/vim-prisma'
Plug 'jparise/vim-graphql'
Plug 'puremourning/vimspector'
call plug#end()


set cursorline cursorcolumnit() n
set list																	" visible whitespace
set hidden					" allow switching away from un-saved buffers
set belloff=all

" load up bash_profile
set shell=bash\ --login

" gutentag
let g:gutentags_modules = ['ctags'] ", 'gtags_cscope']
let g:gutentags_cache_dir = expand('~/.vim/tags')
let g:gutentags_file_list_command = 'rg --files'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

let g:markdown_fenced_languages = ['html', 'js=javascript']
