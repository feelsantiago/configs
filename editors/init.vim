call plug#begin()
        " Appearance
    Plug 'vim-airline/vim-airline'
    Plug 'ryanoasis/vim-devicons'
    Plug 'arcticicestudio/nord-vim'

    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'
    Plug 'chaoren/vim-wordmotion'
    Plug 'tpope/vim-commentary'
    Plug 'kien/ctrlp.vim'

    " Completion / linters / formatters
    Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}
    Plug 'plasticboy/vim-markdown'

    " Git
    Plug 'airblade/vim-gitgutter'

call plug#end()

filetype plugin indent on
syntax on

" Options
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set hidden
set inccommand=split
set mouse=a
set number
set title
set splitbelow splitright
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=4
set tabstop=4

" CamelCaseMotion
let g:wordmotion_nomap = 1

" True color if available
let term_program = $TERM_PROGRAM

" Check for conflicts with Apple Terminal app
if term_program !=? 'Apple_Terminal'
        set termguicolors
else
        if $TERM !=? 'xterm-256color'
                set termguicolors
        endif
endif

" Color scheme and themes
let t_Co = 256
colorscheme nord

" irline
let g:airline_theme = 'sobrio'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Italics
let &t_ZH = "\e[3m"
let &t_ZR = "\e[23m"

" File browser
let NERDTreeShowHidden=1

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1

" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

" Language server stuff
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Leader
let mapleader = ','

" Motion mapping
nmap w          <Plug>WordMotion_w
nmap b          <Plug>WordMotion_b
nmap gE         <Plug>WordMotion_gE
omap aW         <Plug>WordMotion_aW
cmap <C-R><C-W> <Plug>WordMotion_<C-R><C-W>

" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F4> :bd<CR>
nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F6> :sp<CR>:terminal<CR>
nnoremap <F10> :CocCommand tsserver.organizeImports<CR>
nnoremap <C-n> :nohl<CR>

" Tabs
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>

" Terminal Quit
tnoremap <Esc> <C-\><C-n>

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gh <Plug>(coc-references)

inoremap <expr> <S-J> pumvisible() ? "\<C-n>" : "\<S-J>"
inoremap <expr> <S-K> pumvisible() ? "\<C-p>" : "\<S-K>"

autocmd CursorHold * silent call CocActionAsync('highlight')

" Auto Commands
augroup auto_commands
        autocmd BufWrite *.py call CocAction('format')
        autocmd BufWrite *.php call CocAction('runCommand','php-cs-fixer.fix')
        autocmd FileType scss setlocal iskeyword+=@-@
augroup END

" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree | wincmd p

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif