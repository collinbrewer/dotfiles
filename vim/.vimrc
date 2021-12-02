if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'sgur/vim-editorconfig'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tomtom/tcomment_vim'
Plug 'henrik/vim-indexed-search'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
Plug 'joshdick/onedark.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'janko-m/vim-test'
Plug 'eliba2/vim-node-inspect'
Plug 'airblade/vim-gitgutter'
call plug#end()

" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --line-number --no-heading --color=always --hidden '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)
command! -bang -nargs=* Rgi
  \ call fzf#vim#grep(
  \   'rg --line-number --no-heading --color=always --hidden --no-ignore '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%', '?'),
  \   <bang>0)

" netrw
let g:netrw_browse_split = 4	" open files in non-netrw split
let g:netrw_winsize = 25
let g:netrw_altv = 1					" open files on the right
let g:netrw_banner = 0

" rainbow parens
au VimEnter * RainbowParentheses

set cursorline
set hlsearch ignorecase
set list																	" visible whitespace
set softtabstop=2 tabstop=2 shiftwidth=2
set number relativenumber
set hidden					" allow switching away from un-saved buffers
set belloff=all

set directory=~/.vim/swap//,/tmp
set undodir=~/.vim/undo//,/tmp
set undofile

" load up bash_profile
set shell=bash\ --login

" color scheme
colorscheme onedark
set background=dark
hi Normal guibg=NONE ctermbg=NONE

" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
" `gui` is the hex color code used in GUI mode/nvim true-color mode
" `cterm` is the color code used in 256-color mode
" `cterm16` is the color code used in 16-color mode
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif

autocmd FileType yml setl expandtab

let g:netrw_list_hide= '.*\.swp$,.DS_Store,*/tmp/*,*.so,*.swp,*.zip,*.git,^\.\.\=/\=$'

" gutentag
let g:gutentags_modules = ['ctags'] ", 'gtags_cscope']
let g:gutentags_cache_dir = expand('~/.vim/tags')
let g:gutentags_file_list_command = 'rg --files'

" coc
set cmdheight=2
set updatetime=300
set shortmess+=c
" let g:coc_global_extensions = []

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
	inoremap <silent><expr> <c-space> coc#refresh()
else
	inoremap <silent><expr> <c-@> coc#refresh()
endif


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

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" if isdirectory('./node_modules/eslint')
"   let g:coc_global_extensions += ['coc-eslint']
" endif
"
" if isdirectory('./node_modules/flow-bin')
" 	let g:coc_global_extensions += ['coc-flow']
" endif
"
" if isdirectory('./node_modules/typescript')
" 	let g:coc_global_extensions += ['coc-tsserver']
" endif


" WSL yank support
" let s:clip = '/mntrc/Windows/system32/clip.exe'  " change this path according to your mount point
let s:clip = 'clip.exe'  " change this path according to your mount point
if executable(s:clip)
	augroup WSLYank
		autocmd!
		autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
	augroup END
endif

" js log helpers
imap cll console.log();<Esc>==F(a
vmap cll yocll<Esc>p
nmap cll yiwocll<Esc>p
