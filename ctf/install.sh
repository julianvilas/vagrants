#!/bin/bash
set -e

echo 'Installing dependencies'
sudo apt-get update
sudo apt-get install -y --no-install-recommends curl git build-essential gdb gnupg python python-pip libpython-dev python-qt4 cmake virtualenvwrapper libffi-dev golang-1.8-go

export PATH=/usr/lib/go-1.8/bin:$PATH

# vim
echo 'Tunning VIM'
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -LSso ~/.vimrc https://raw.githubusercontent.com/julianvilas/dotfiles/master/vimrc
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
git clone https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

mkdir -p ~/gocode
echo 'Getting golang tools'
GOPATH=$HOME/gocode go get -v golang.org/x/tools/... github.com/nsf/gocode

~/gocode/src/github.com/nsf/gocode/vim/pathogen_update.sh

echo 'export GOPATH=$HOME/gocode
export PATH=/usr/lib/go-1.8/bin:$GOPATH/bin:$PATH
export EDITOR=vim' >> ~/.profile

# rvm, ruby
echo 'Installing ruby and rvm'
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s stable
. ~/.rvm/scripts/rvm
rvm install 2.3
rvm --default use 2.3
rvm docs generate

# src
mkdir -p ~/src

# vivisect
git clone https://github.com/vivisect/vivisect.git ~/src/vivisect

# metasm
git clone https://github.com/jjyg/metasm.git ~/src/metasm

# radare2
echo 'Compiling r2'
git clone https://github.com/radare/radare2.git ~/src/radare2
cd ~/src/radare2 && ./sys/install.sh

# peda
git clone https://github.com/longld/peda.git ~/src/peda
echo "set disassembly-flavor intel" > ~/.gdbinit
echo "source ~/src/peda/peda.py" >> ~/.gdbinit

pip install -U pip setuptools
pip install --upgrade pip

# capstone, keystone
pip install --user capstone keystone-engine

# ropgadget
pip install --user ropgadget

# pwntools
pip install --user pwntools

# angr
pip install --user angr
