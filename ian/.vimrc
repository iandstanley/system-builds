
" Use Vim's own package manager

" Key binding
" ===========
"
" F2    Open netrw
" F6    Spell
" F7    Goyo
" F9    Make
" F11   numbering on/off
"

" XDG settings for VIM
" IGNORED AS THEY ARE NOW IN ~/system-builds
"dump swap files, backup files, viminfo files    in cache directory
"set directory=$XDG_CACHE_HOME/vim,~/,/tmp
"set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
"set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
"set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME

packloadall

set nocompatible              " be iMproved, required
filetype plugin on
"syntax on      " default syntax 
syntax enable

set relativenumber
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set ai "auto indent
set si "smart indent
set ignorecase
set smartcase
set showcmd "show cmd in bottom bar
set hlsearch
set incsearch 
set foldenable 
set foldlevelstart=10
set foldmethod=indent
set showmatch
set encoding=utf8
set wrap "wraplines
set wildmenu

set cm=blowfish2    " use Blowfish2 for encrypted files, use :X to encrypt

" BACKUP
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup


" MARKDOWN 
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.mom setlocal textwidth=80
au BufRead,BufNewFile *.wiki setlocal textwidth=70  " vimwiki format
" you can use the normal command 'gq' to reformat

" SPELLING 
set spelllang=en_gb
autocmd BufRead,BufNewFile *.md  setlocal spell
autocmd FileType gitcommit  setlocal spell
set complete+=kspell 

fu! ToggleCurline ()
  if &cursorline && &cursorcolumn
    set nocursorline
    set nocursorcolumn
  else
    set cursorline
    set cursorcolumn
  endif
endfunction

" open file browser on F2
map <Esc>OQ <F2>    "fix for weird bug in Raspberry Pi
let g:NetrwIsOpen=0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
    silent Lexplore
endif
endfunction
map <F2> :call ToggleNetrw() <CR>

"map <F4> :call ToggleCurline()<CR>
map <F6> :setlocal spell! spelllang=en_gb<CR>
map <F7> :Goyo<CR>
map <F9> :make<CR>
map <F11> :set invnumber invrelativenumber<CR>
"map <C-F10> :Limelight!!<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vifm file manager
"
" commands:
"           Vifm        open file(s)
"           EditVifm    open file(s)
"           SplitVifm   split biffer and open file(s)
"           VsplitVifm  vertically split buffer and open file(s)
"           DiffVifm    load file for :vert diffsplit
"           TabVifm     load file or files in tabs
" END Vifm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIMWIKI
"let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.wiki'}]
let g:vimwiki_list = [{'path': '~/.vimwiki/', 'syntax': 'vimwiki', 'ext': '.wiki'}]

let g:vimwiki_global_ext = 0 
" Now files outside the wiki with the wiki page extension will have filetype=vimwiki


"  Generate Vimwiki Diary links each time it is opened
command! Diary VimwikiDiaryIndex
augroup vimwikigroup
    autocmd!
    " automatically update links on read diary
    autocmd BufRead,BufNewFile diary.wiki VimwikiDiaryGenerateLinks
augroup end
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline.vim
"
set laststatus=2
let g:lightline = {
            \ 'colorscheme':'wombat',
            \ }
if !has('gui_running')
  set t_Co=256
endif
"There are many lightline colorschemes available. 
"See :h g:lightline.colorscheme for the complete list.
"
" See https://github.com/itchyny/lightline.vim
" END lightline.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-Markdown config
" 
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
" END vim-markdown config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LIMELIGHT CONFIG
"
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
" Default: 0.5
let g:limelight_default_coefficient = 0.7
" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1
" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'
" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
"
" END LIMELIGHT CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev lorem  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec elit risus, dapibus eu ipsum vitae, euismod vulputate dui. Proin sapien urna, convallis nec lectus in, dignissim bibendum nisl. Nunc sit amet nisl leo. In bibendum, ligula ac vulputate scelerisque, risus diam lacinia odio, vel commodo lorem mauris eu elit. Sed tempor metus quam, nec sodales est placerat id. Aliquam interdum massa vitae sapien finibus fringilla. Proin felis eros, pulvinar vehicula congue eget, pretium vel nibh. Vestibulum mollis dictum odio. Nam a hendrerit diam. In quis orci semper eros pharetra malesuada a quis mi. Vivamus tincidunt ligula quis eros euismod molestie. Cras ut justo nisl. Nullam vestibulum magna neque, vel placerat diam vehicula vitae.


nmap <leader>j vipJ<CR>
" Sabbath book project
autocmd BufRead,BufNewFile sabbath.md iabbrev sabbath Sabbath
autocmd BufRead,BufNewFile sabbath.md iabbrev christian Christian
function SabbathAutocorrect()
    let l:_save_pos = getpos('.')   " save position
    %s/sabbath/Sabbath/g
    call setpos('.', l:_save_pos)   " restore position
endfunction
autocmd BufWritePre  sabbath.md  :call SabbathAutocorrect()
autocmd BufRead,BufNewFile sabbath.md  setlocal textwidth=72
"autocmd BufWritePost sabbath.md  make 
autocmd BufRead,BufNewFile sabbath.md  let b:pandoc_biblio_bibs = "sabbath.bib"
" autocmd BufRead, BufNewFile sabbath.md let |g:pandoc#command#autoexec_on_writes = 1|
" autocmd BufRead, BufNewFile sabbath.md let |b:pandoc_command_autoexec_command| = "Pandoc! pdf"
autocmd BufRead,BufNewFile sabbath.md  let g:pandoc#biblio#sources = "bcgyG"
"autocmd BufRead,BufNewFile sabbath.md  let g:pandoc#completion#bib#mode = "citeproc"
