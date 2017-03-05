" configuration for bundle {{{1
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-fugitive'
Plugin 'xolox/vim-notes'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/vim-easy-align'
Plugin 'Raimondi/delimitMate'
Plugin 'dkprice/vim-easygrep'
"Plugin 'minibufexplorerpp'
Plugin 'winmanager'
Plugin 'matchit.zip'
Plugin 'a.vim'
Plugin 'luochen1990/rainbow'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'skywind3000/vimmake'

Plugin 'Shougo/unite.vim'
Plugin 'Shougo/denite.nvim'
call vundle#end()
filetype plugin indent syntax on

" vim: ft=vim
