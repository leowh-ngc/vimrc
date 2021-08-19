syntax on

set nu
set nocompatible	" 关闭vi兼容模式
set cursorline		" 突出显示当前行
set encoding=utf-8
set langmenu=zh_CN.utf-8
set termencoding=utf-8
set formatoptions+=mM
set fencs=ucs-bom,utf-8,default,latin1
set tabstop=4
set shiftwidth=4	" 设定<<和>>命令移动时的宽度为4
set softtabstop=4	" 退格键可以一次删除4个空格
set backspace=indent,eol,start
set helplang=cn
set backupcopy=yes	" 如果开启备份，备份时的行为为覆盖
set nowrapscan		" 禁止循环搜索
set smartindent
set laststatus=2
" set foldenable		" 开启折叠
" set foldmethod=syntax	" 语法折叠

" coc插件的某些language server的备份会有问题
set nobackup
set nowritebackup

"set guifont=FantasqueSansMono\ NF\ 20
"colorscheme atom-dark

vnoremap <leader><space> "+
nnoremap <leader><space> "+

inoremap <Space>ll <Esc>la
inoremap <Space>hh <Esc>i
inoremap <Space>jj <Esc>o
inoremap <Space>kk <Esc>O

nnoremap <Leader>d :bd<CR>
nnoremap <Leader>j :bn<CR>
nnoremap <Leader>k :bp<CR>
nnoremap <Leader>h :tabp<CR>
nnoremap <Leader>l :tabn<CR>

" 退出终端
tnoremap <Esc> <C-\><C-n>
" 打开终端
nnoremap <M-t> :terminal<CR>

" 打开本文件
command! -nargs=0 Oinit :exec "e ~/.config/nvim/init.vim"
command! -nargs=0 Sinit :exec "source ~/.config/nvim/init.vim"

call plug#begin('~/.config/nvim/autoload/plugged')

Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" 状态栏扩展配置
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:airline#extensions#tabline#formatter='default'

" ---------------- NERDTree配置 ---------------- "
nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <leader>t :NERDTree<CR>
let g:NERDSpaceDelims = 1		" 注释后面跟空格
let g:NERDToggleCheckAllLines = 1

" ---------------------------- coc配置 ------------------------------- "
set signcolumn="yes"
set shortmess+=c
set updatetime=300

" 激活coc补全
inoremap <silent><expr> <c-space> coc#refresh()

" tab补全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 跳转错误
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" 跳转定义
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gtd <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" 在预览窗口查看文档
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 高亮光标所在变量
autocmd CursorHold * silent call CocActionAsync('highlight')

" 重命名变量
nmap <F2> <Plug>(coc-rename)

" 执行问题建议
nmap <M-CR> <Plug>(coc-fix-current)

" 格式化代码
" 添加 `:Format` 命令，用于格式化当前buffer
command! -nargs=0 Format :call CocAction('format')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"xmap <M-F> <Plug>(coc-format-selected)
"nmap <M-F> <Plug>(coc-format-selected)
nnoremap <C-M-l> :Format<CR>
nnoremap <M-F> :Prettier<CR>

" 折叠当前buffer的代码
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" 重新组织import等导入语句
command! -nargs=0 Reimport :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" 添加原生的状态栏支持
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ----------------------------------------- "
let g:coc_global_exetensions=[
	\ 'coc-vimlsp',
	\ 'coc-tsserver*',
	\ 'coc-tslint*',
	\ 'coc-vetur*',
	\ 'coc-sql'
\]

