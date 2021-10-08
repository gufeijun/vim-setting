"colorscheme paradox
"colorscheme dracula
"colorscheme desert
"colorscheme monokai
"colorscheme desert256
"colorscheme gruvbox
colorscheme papercol

set vb t_vb=        "关闭vim提示音
set nocompatible	"不兼容vi
set synmaxcol=500	"不高亮长句
set noerrorbells	"不要发出声音
set showmatch		"高亮匹配的括号
set matchtime=2		"括号显示时间
set autoindent		"自动缩进
set cindent			"像c一样缩进
set tabstop=4		"制表符
set softtabstop=4 	"统一缩进4
set shiftwidth=4 	"统一缩进4
set expandtab		"展开tab
set nu				"行号
set bs=eol,start,indent	"backspace 键模式
" Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set winaltkeys=no
set nowrap			"关闭自动换行
set ruler			"显示光标位置
set ignorecase		"搜索时忽略大小写
set smartcase
set hlsearch		"高亮搜索内容
set encoding=utf-8
set fileencoding=utf-8

if has('syntax')
	syntax on			"语法高亮
	syntax enable		"语法高亮
endif

if has('autocmd')
	filetype plugin indent on
endif

"显示最后一行
set display=lastline
"允许下方显示目录
set wildmenu
" 延迟绘制（提升性能）
set lazyredraw
" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m
" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
" 设置 tags：当前文件所在目录往上向根目录搜索直到碰到 .tags 文件
" 或者 Vim 当前目录包含 .tags 文件
set tags=./.tags;,.tags
" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
" 文件换行符，默认使用 unix 换行符
set ffs=unix,dos,mac

set laststatus=2	"总是显示状态栏
set signcolumn=yes	"显示侧边栏
set showtabline=2	" 总是显示标签栏
set showcmd			"右下角显示命令
" 设置黑色背景
set background=light
" 允许 256 色
set t_Co=256

" v 模式下复制内容到系统剪切板
vmap <Leader>c "+yy
" n 模式下复制一行到系统剪切板
nmap <Leader>c "+yy
" n 模式下粘贴系统剪切板的内容
nmap <Leader>v "+p

"----------------------------------------------------------------------
" 状态栏设置
"----------------------------------------------------------------------
set statusline=                                 " 清空状态了
set statusline+=\ %F                            " 文件名
set statusline+=\ [%1*%M%*%n%R%H]               " buffer 编号和状态
set statusline+=%=                              " 向右对齐
set statusline+=\ %y                            " 文件类型

" 最右边显示文件编码和行号等信息，并且固定在一个 group 中，优先占位
set statusline+=\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %v:%l/%L%)

" 修改行号为浅灰色，默认主题的黄色行号很难看，换主题可以仿照修改
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE 
	\ gui=NONE guifg=DarkGrey guibg=NONE

" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
if has('gui_running')
	hi! SpellBad gui=undercurl guisp=red
	hi! SpellCap gui=undercurl guisp=blue
	hi! SpellRare gui=undercurl guisp=magenta
	hi! SpellRare gui=undercurl guisp=cyan
else
	hi! SpellBad term=standout ctermfg=1 term=underline cterm=underline
	hi! SpellCap term=underline cterm=underline
	hi! SpellRare term=underline cterm=underline
	hi! SpellLocal term=underline cterm=underline
endif


"----------------------------------------------------------------------
" 按键设置
"----------------------------------------------------------------------
" 设置 CTRL+HJKL 移动光标（INSERT 模式偶尔需要移动的方便些）
noremap <C-h> <left>
noremap <C-j> <down>
noremap <C-k> <up>
noremap <C-l> <right>
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>

"----------------------------------------------------------------------
" 终端下允许 ALT
"----------------------------------------------------------------------
" 打开功能键超时检测（终端下功能键为一串 ESC 开头的字符串）
set ttimeout
" 功能键超时检测 50 毫秒
set ttimeoutlen=50
if has('nvim') == 0 && has('gui_running') == 0
	function! s:metacode(key)
		exec "set <M-".a:key.">=\e".a:key
	endfunc
	for i in range(10)
		call s:metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(nr2char(char2nr('a') + i))
		call s:metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '{', '}']
		call s:metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:metacode(c)
	endfor
endif

"----------------------------------------------------------------------
" 功能键终端码矫正
"----------------------------------------------------------------------
function! s:key_escape(name, code) 
	if has('nvim') == 0 && has('gui_running') == 0
		exec "set ".a:name."=\e".a:code
	endif
endfunc

call s:key_escape('<F1>', 'OP')
call s:key_escape('<F2>', 'OQ')
call s:key_escape('<F3>', 'OR')
call s:key_escape('<F4>', 'OS')
call s:key_escape('<S-F1>', '[1;2P')
call s:key_escape('<S-F2>', '[1;2Q')
call s:key_escape('<S-F3>', '[1;2R')
call s:key_escape('<S-F4>', '[1;2S')
call s:key_escape('<S-F5>', '[15;2~')
call s:key_escape('<S-F6>', '[17;2~')
call s:key_escape('<S-F7>', '[18;2~')
call s:key_escape('<S-F8>', '[19;2~')
call s:key_escape('<S-F9>', '[20;2~')
call s:key_escape('<S-F10>', '[21;2~')
call s:key_escape('<S-F11>', '[23;2~')
call s:key_escape('<S-F12>', '[24;2~')

"----------------------------------------------------------------------
" ALT+N 切换 tab
"----------------------------------------------------------------------
noremap <silent><m-1> :tabn 1<cr>
noremap <silent><m-2> :tabn 2<cr>
noremap <silent><m-3> :tabn 3<cr>
noremap <silent><m-4> :tabn 4<cr>
noremap <silent><m-5> :tabn 5<cr>
noremap <silent><m-6> :tabn 6<cr>
noremap <silent><m-7> :tabn 7<cr>
noremap <silent><m-8> :tabn 8<cr>
noremap <silent><m-9> :tabn 9<cr>
noremap <silent><m-0> :tabn 10<cr>
inoremap <silent><m-1> <ESC>:tabn 1<cr>
inoremap <silent><m-2> <ESC>:tabn 2<cr>
inoremap <silent><m-3> <ESC>:tabn 3<cr>
inoremap <silent><m-4> <ESC>:tabn 4<cr>
inoremap <silent><m-5> <ESC>:tabn 5<cr>
inoremap <silent><m-6> <ESC>:tabn 6<cr>
inoremap <silent><m-7> <ESC>:tabn 7<cr>
inoremap <silent><m-8> <ESC>:tabn 8<cr>
inoremap <silent><m-9> <ESC>:tabn 9<cr>
inoremap <silent><m-0> <ESC>:tabn 10<cr>
" 左移 tab
function! Tab_MoveLeft()
	let l:tabnr = tabpagenr() - 2
	if l:tabnr >= 0
		exec 'tabmove '.l:tabnr
	endif
endfunc

" 右移 tab
function! Tab_MoveRight()
	let l:tabnr = tabpagenr() + 1
	if l:tabnr <= tabpagenr('$')
		exec 'tabmove '.l:tabnr
	endif
endfunc
noremap <silent><m-left> :call Tab_MoveLeft()<cr>
noremap <silent><m-right> :call Tab_MoveRight()<cr>
noremap <silent><m-l> :call Tab_MoveRight()<cr>
noremap <silent><m-k> :call Tab_MoveRight()<cr>
noremap <silent><m-j> :call Tab_MoveLeft()<cr>

"----------------------------------------------------------------------
" 插件区
"----------------------------------------------------------------------
call plug#begin('~/.vim/bundles')

Plug 'KeitaNakamura/neodark.vim'
" colorscheme neodark
" colorscheme monokai
"Plug 'crusoexia/vim-monokai'
" colorscheme github 
"Plug 'acarapetis/vim-colors-github'
" colorscheme one 
"Plug 'rakr/vim-one'


"----------------------------------------------------------------------
" 方便移动
"----------------------------------------------------------------------
Plug 'easymotion/vim-easymotion'

"----------------------------------------------------------------------
" 用于在侧边符号栏显示 git/svn 的 diff
"----------------------------------------------------------------------
Plug 'mhinz/vim-signify'
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change
let g:signify_vcs_cmds = {
		\ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
		\}
"----------------------------------------------------------------------
" 目录树
"----------------------------------------------------------------------
Plug 'preservim/nerdtree'
nmap <F3> :NERDTreeToggle <cr>

"----------------------------------------------------------------------
" 方便函数注释
"----------------------------------------------------------------------
Plug 'vim-scripts/DoxygenToolkit.vim'
":Dox给函数注释

"----------------------------------------------------------------------
" 格式化代码
"----------------------------------------------------------------------
Plug 'rhysd/vim-clang-format'
let g:clang_format#style_options = {
            \ 'AccessModifierOffset' : -4,
            \ 'AllowShortIfStatementsOnASingleLine' : 'true',
            \ 'AlwaysBreakTemplateDeclarations' : 'true',
            \ 'Standard' : 'C++11',
            \ 'BreakBeforeBraces' : 'Attach'} "大括号不换行
"llvm,google,chromium,mozilla is supported
let g:clang_format#code_style = 'google'
"auto format
let g:clang_format#auto_format=1

"----------------------------------------------------------------------
" 括号，引号自动补全
"----------------------------------------------------------------------
Plug 'Raimondi/delimitMate'

"----------------------------------------------------------------------
" 状态栏美化
"----------------------------------------------------------------------
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_section_b = '%n'
let g:airline_theme='deus'
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#csv#enabled = 0
let g:airline#extensions#vimagit#enabled = 0


"----------------------------------------------------------------------
" ale语法检查
"----------------------------------------------------------------------
Plug 'dense-analysis/ale'
" 设定延迟和提示信息
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
" let g:ale_sign_error = '\ue009\ue009'

" 设定检测的时机：
"①normal模式：文字改变，或者离开 insert模式
"②nerver模式：仅保存时才检查，看个人喜好
let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_text_changed = 'normal'

" 禁用默认 INSERT 模式下改变文字也触发的设置，太频繁外，还会让补全窗闪烁
let g:ale_lint_on_insert_leave = 1

" 在 linux/mac 下降低语法检查程序的进程优先级（不要卡到前台进程）
if has('win32') == 0 && has('win64') == 0 && has('win32unix') == 0
	let g:ale_command_wrapper = 'nice -n5'
endif
" 允许 airline 集成
let g:airline#extensions#ale#enabled = 1
" 编辑不同文件类型需要的语法检查器
let g:ale_linters = {
			\ 'python': ['flake8', 'pylint'],
			\ 'lua': ['luac'],
			\ 'java': ['javac'],
			\ 'javascript': ['eslint'],
			\ 'go': ['gopl','gofmt','go build'],
			\ }
			"\ 'c': ['gcc', 'cppcheck'],
			"\ 'cpp': ['g++', 'cppcheck'],
			"利用go-vim的提示
			"\ 'go': ['gopl','gofmt','go build'],
"let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
"let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
"let g:ale_c_cppcheck_options = ''
"let g:ale_cpp_cppcheck_options = ''
"let g:ale_linters.text = ['textlint', 'write-good', 'languagetool']
"" 如果没有 gcc 只有 clang 时（FreeBSD）
"if executable('gcc') == 0 && executable('clang')
"	let g:ale_linters.c += ['clang']
"	let g:ale_linters.cpp += ['clang']
"endif

"----------------------------------------------------------------------
" 自动补全
"----------------------------------------------------------------------
Plug 'ycm-core/YouCompleteMe'
"不同语言的补全需要单独安装
au FileType c nmap gd :tab YcmCompleter GoToDefinition<cr>
au FileType cpp nmap gd :YcmCompleter GoToDefinition<cr>
au FileType hpp nmap gd :YcmCompleter GoToDefinition<cr>
au FileType h nmap gd :YcmCompleter GoToDefinition<cr>
" 禁用预览功能，根据喜好打开
let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_show_diagnostics_ui = 0
let g:ycm_filter_diagnostics = { 'go': {'regex': '.*'} }
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_goto_buffer_command='split'
set completeopt=menu,menuone
" 两个字符自动触发语义补全
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
"白名单
let g:ycm_filetype_whitelist = {
			\ "c":1,
			\ "cpp":1,
			\ "objc":1,
			\ "objcpp":1,
			\ "python":1,
			\ "java":1,
			\ "javascript":1,
			\ "coffee":1,
			\ "vim":1,
			\ "go":1,
			\ "cs":1,
			\ "lua":1,
			\ "perl":1,
			\ "perl6":1,
			\ "php":1,
			\ "ruby":1,
			\ "rust":1,
			\ "erlang":1,
			\ "asm":1,
			\ "nasm":1,
			\ "masm":1,
			\ "tasm":1,
			\ "asm68k":1,
			\ "asmh8300":1,
			\ "asciidoc":1,
			\ "basic":1,
			\ "vb":1,
			\ "make":1,
			\ "cmake":1,
			\ "html":1,
			\ "css":1,
			\ "less":1,
			\ "json":1,
			\ "cson":1,
			\ "typedscript":1,
			\ "haskell":1,
			\ "lhaskell":1,
			\ "lisp":1,
			\ "scheme":1,
			\ "sdl":1,
			\ "sh":1,
			\ "zsh":1,
			\ "bash":1,
			\ "man":1,
			\ "markdown":1,
			\ "matlab":1,
			\ "maxima":1,
			\ "dosini":1,
			\ "conf":1,
			\ "config":1,
			\ "zimbu":1,
			\ "ps1":1,
			\ }
"----------------------------------------------------------------------
" echodoc：搭配 YCM/deoplete 在底部显示函数参数
"----------------------------------------------------------------------
Plug 'Shougo/echodoc.vim'
set noshowmode
let g:echodoc#enable_at_startup = 1

"----------------------------------------------------------------------
" golang插件
"----------------------------------------------------------------------
Plug 'fatih/vim-go'
"vim-go配置
let g:go_auto_type_info = 0
let g:go_highlight_types = 1
let g:go_fmt_fail_silently = 1
let g:go_list_height = 0
"disbale gd of vim-go
let g:go_def_mapping_enabled = 0
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 0
let g:go_highlight_string_spellcheck = 1

au FileType go nmap gd <Plug>(go-def-tab)

" 更清晰的错误标注：默认一片红色背景，语法高亮都被搞没了
" 只显示红色或者蓝色下划线或者波浪线
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! clear SpellLocal
if has('gui_running')
	hi! SpellBad gui=undercurl guisp=red
	hi! SpellCap gui=undercurl guisp=blue
	hi! SpellRare gui=undercurl guisp=magenta
	hi! SpellRare gui=undercurl guisp=cyan
else
	hi! SpellBad term=standout ctermfg=1 term=underline cterm=underline
	hi! SpellCap term=underline cterm=underline
	hi! SpellRare term=underline cterm=underline
	hi! SpellLocal term=underline cterm=underline
endif
" 去掉 sign column 的白色背景
hi! SignColumn guibg=NONE ctermbg=NONE
" 修正补全目录的色彩：默认太难看
hi! Pmenu guibg=gray guifg=black ctermbg=gray ctermfg=black
hi! PmenuSel guibg=gray guifg=brown ctermbg=brown ctermfg=gray

"注释插件
"gc注释或取消注释选中的块
"gcc注释或取消注释当前行
"gcap注释当前函数
Plug 'tpope/vim-commentary'
setglobal commentstring=#\ %s
augroup comments
  autocmd!
  autocmd FileType go,c,cpp,cs,java,arduino setlocal commentstring=//\ %s
augroup END

call plug#end()

"normal模式光标为fillbox，insert为|
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_SR.="\e[4 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

"wsl用户应该将该区域取消注释
"wsl系统剪切板支持，需要下载win32yank并配置PATH，https://github.com/equalsraf/win32yank
" autocmd TextYankPost * call YankDebounced()
" function! Yank(timer)
"     call system('win32yank.exe -i --crlf', @")
"     redraw!
" endfunction

" let g:yank_debounce_time_ms = 500
" let g:yank_debounce_timer_id = -1

" function! YankDebounced()
"     let l:now = localtime()
"     call timer_stop(g:yank_debounce_timer_id)
"     let g:yank_debounce_timer_id = timer_start(g:yank_debounce_time_ms, 'Yank')
" endfunction

" function! Paste(mode)
"     let @" = system('win32yank.exe -o --lf')
"     return a:mode
" endfunction

" map <expr> p Paste('p')
" map <expr> P Paste('P')
