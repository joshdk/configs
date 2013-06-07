syntax on
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set number
set paste
set nowrap
set incsearch
set hlsearch
set modeline
set fdm=marker
set encoding=utf-8
set ignorecase smartcase
set scrolloff=8
set timeout timeoutlen=1000 ttimeoutlen=100
set list listchars=tab:│\ ,eol:\ ,trail:•


"{{{ Colorscheme settings
colorscheme BusyBee
highlight SpecialKey ctermfg=7
highlight NonText ctermfg=7
highlight LineNr ctermfg=7
"}}}


"{{{ Statusline settings
	set laststatus=2
	set statusline=%F\ %m%r%y\ [0x\%02.2B]\ \%=[%-3l,%-2c][%-L,%-4o]
	highlight StatusLine ctermbg=0 ctermfg=7 cterm=bold
"}}}


"{{{ Nerdtree settings
let NERD_java_alt_style=1
let NERD_c_alt_style=1
let NERDDefaultNesting=1
let NERDSpaceDelims=1
"}}}


"{{{ Define fold mappings
	function! NeatFoldText()
		let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
		let lines_count = v:foldend - v:foldstart + 1
		let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
		let foldchar = split(filter(split(&fillchars, ','), 'v:val =~# "fold"')[0], ':')[-1]
		let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
		let foldtextend = lines_count_text . repeat(foldchar, 8)
		let length = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g'))
		return foldtextstart . repeat(foldchar, winwidth(0)-length) . foldtextend
	endfunction
	set foldtext=NeatFoldText()

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

au FileType c,cpp,java,javascript vnoremap . :call   Comment('\/\/ ', '')<CR>:noh<CR>gv
au FileType c,cpp,java,javascript vnoremap , :call Uncomment('\/\/ ', '')<CR>:noh<CR>gv

au FileType html,xml vnoremap . :call   Comment('<!-- ', ' -->')<CR>:noh<CR>gv
au FileType html,xml vnoremap , :call Uncomment('<!-- ', ' -->')<CR>:noh<CR>gv

au FileType vim vnoremap . :call   Comment('" ', '')<CR>:noh<CR>gv
au FileType vim vnoremap , :call Uncomment('" ', '')<CR>:noh<CR>gv

au FileType lua,haskell vnoremap . :call   Comment('-- ', '')<CR>:noh<CR>gv
au FileType lua,haskell vnoremap , :call Uncomment('-- ', '')<CR>:noh<CR>gv

au FileType tex vnoremap . :call   Comment('% ', '')<CR>:noh<CR>gv
au FileType tex vnoremap , :call Uncomment('% ', '')<CR>:noh<CR>gv
"}}}


 "{{{ Custom highlighting
" Define an Error highlight group
highlight Error ctermbg=red ctermfg=white

" Match lines over 80 characters long
let h1 = matchadd('Error', '\%81v.\+')

" Match libes that mix tabs and spaces
let h2 = matchadd('Error', '^\s*\ \t\s*')
let h3 = matchadd('Error', '^\s*\t\ \s*')

" Match trailing whitespace
let h4 = matchadd('Error', '\s\+$')


au FileType md,tex :call matchdelete(h1)
au FileType md,tex :set spell
"}}}
