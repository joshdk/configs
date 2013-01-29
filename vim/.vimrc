syntax on
filetype plugin indent on

"tab display config
set tabstop=4
set shiftwidth=4
set number
set paste
set nowrap
set incsearch
set hlsearch
set modeline
set fdm=marker

set list listchars=tab:│\ ,eol:\ ,trail:•

highlight SpecialKey ctermfg=7
highlight NonText ctermfg=7
highlight LineNr ctermfg=7

"statusline config
	set laststatus=2
	set statusline=%F\ %m%r%y\ [0x\%02.2B]\ \%=[%-3l,%-2c][%-L,%-4o]
	highlight StatusLine ctermbg=0 ctermfg=7 cterm=bold

colorscheme BusyBee


"{{{ Nerdtree settings
let NERD_java_alt_style=1
let NERD_c_alt_style=1
let NERDDefaultNesting=1
let NERDSpaceDelims=1
"}}}


"{{{ Define fold mappings
	nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
	vnoremap <Space> zf
"}}}


"{{{ Define indent mappings
	vnoremap > >gv
	vnoremap < <gv
	au FileType yaml vnoremap > :s/^/    /g<CR>:noh<CR>gv
	au FileType yaml vnoremap < :s/^    //g<CR>:noh<CR>gv
"}}}


"{{{ Commenting functions
function! Comment(ldelim, rdelim)
	let current_line = getline(".")
	let modified_line = substitute(current_line, '^\(\s*\)\(.\+\)$', '\1' . a:ldelim . '\2' . a:rdelim, "g")
	call setline(".", modified_line)
endfunction

function! Uncomment(ldelim, rdelim)
	let current_line = getline(".")
	let modified_line = substitute(current_line, '^\(\s*\)' . a:ldelim . '\(.*\)' . a:rdelim . '$', '\1\2', "g")
	call setline(".", modified_line)
endfunction
"}}}


"{{{ Define comment mappings
vnoremap . :call   Comment('# ', '')<CR>:noh<CR>gv
vnoremap , :call Uncomment('# ', '')<CR>:noh<CR>gv

au FileType c,cpp,java vnoremap . :call   Comment('\/\/ ', '')<CR>:noh<CR>gv
au FileType c,cpp,java vnoremap , :call Uncomment('\/\/ ', '')<CR>:noh<CR>gv

au FileType html,xml vnoremap . :call   Comment('<!-- ', ' -->')<CR>:noh<CR>gv
au FileType html,xml vnoremap , :call Uncomment('<!-- ', ' -->')<CR>:noh<CR>gv

au FileType vim vnoremap . :call   Comment('" ', '')<CR>:noh<CR>gv
au FileType vim vnoremap , :call Uncomment('" ', '')<CR>:noh<CR>gv

au FileType lua,haskell vnoremap . :call   Comment('-- ', '')<CR>:noh<CR>gv
au FileType lua,haskell vnoremap , :call Uncomment('-- ', '')<CR>:noh<CR>gv

au FileType tex vnoremap . :call   Comment('% ', '')<CR>:noh<CR>gv
au FileType tex vnoremap , :call Uncomment('% ', '')<CR>:noh<CR>gv
"}}}
