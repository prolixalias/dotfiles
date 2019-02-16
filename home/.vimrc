set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'VundleVim/Vundle.vim'

" My bundles here:
Plugin 'Zenburn'

" original repos on GitHub
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/neocomplete.vim'
Plugin 'godlygeek/tabular'
Plugin 'kien/ctrlp.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'tpope/vim-surround'
Plugin 'editorconfig/editorconfig-vim'

" syntax
Plugin 'rodjek/vim-puppet'
Plugin 'fatih/vim-go'
Plugin 'hashivim/vim-terraform'
Plugin 'elixir-lang/vim-elixir'
Plugin 'gabrielelana/vim-markdown'

call vundle#end()             " required
filetype plugin indent on     " required!

:so ~/.vimrc.settings
