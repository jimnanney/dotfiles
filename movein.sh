#!/bin/sh

# Movein script to setup a new machine as a
# development environment

# [ "$OS" = "Darwin" ] # Mac OS X
# [ "$OS" = "Linux" ] # Linux 
OS=$(uname)
if [ "$OS" = "Linux" ]; then
    if [ -e "/etc/os-release" ]; then
        OS=$(cat /etc/os-release |grep -E '^ID='|cut -f2 -d=|sed 's/"//g')
    else
        [ -e "/etc/redhat-release" ] && OS="RHEL"
    fi
fi

TOOLS=$HOME/.tools
ln -s $TOOLS/gemrc $HOME/.gemrc
ln -s $TOOLS/gitconfig $HOME/.gitconfig
ln -s $TOOLS/railsrc $HOME/.railsrc
ln -s $TOOLS/tmux.conf $HOME/.tmux.conf
ln -s $TOOLS/vimrc $HOME/.vimrc
ln -s $TOOLS/zshrc $HOME/.zshrc
ln -s $TOOLS/zshenv $HOME/.zshenv

if [ ! -d "$HOME/.nvm" ]; then 
  # install nvm
  git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
  # install node 4.0.0
  source $HOME/.nvm/nvm.sh
  nvm install 4.0.0
fi

if [ ! -d "$HOME/.rbenv" ]; then
    if [ "$OS" = "RHEL" ]; then
        git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
        git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
        export PATH="$HOME/.rbenv/bin:$PATH"
        eval "$(rbenv init -)"
        rbenv install 2.2.3
        rbenv global 2.2.3
    fi
fi

# Setup my vim plugins
mkdir -p $HOME/.vim/bundle $HOME/.vim/autoload

[ ! -e "$HOME/.vim/autoload/pathogen.vim" ] && \
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

[ ! -d "$HOME/.vim/bundle/ctrlp.vim" ] && \
    git clone https://github.com/kien/ctrlp.vim.git $HOME/bundle/ctrlp.vim

[ ! -d "$HOME/.vim/bundle/editorconfig-vim" ] && \
    git clone https://github.com/editorconfig/editorconfig-vim.git $HOME/.vim/bundle/editorconfig-vim

[ ! -d "$HOME/.vim/bundle/emmet-vim" ] && \
    git clone https://github.com/mattn/emmet-vim.git $HOME/.vim/bundle/emmet-vim

[ ! -d "$HOME/.vim/bundle/html5.vim" ] && \
    git clone https://github.com/othree/html5.vim.git $HOME/.vim/bundle/html5.vim

[ ! -d "$HOME/.vim/bundle/vim-bundler" ] && \
    git clone git://github.com/tpope/vim-bundler.git $HOME/.vim/bundle/vim-bundler

[ ! -d "$HOME/.vim/bundle/vim-coffee-script" ] && \
    git clone https://github.com/kchmck/vim-coffee-script.giti $HOME/.vim/bundle/vim-coffee-script

[ ! -d "$HOME/.vim/bundle/vim-colors-solarized" ] && \
    git clone git://github.com/altercation/vim-colors-solarized.git $HOME/.vim/bundle/vim-endwise

[ ! -d "$HOME/.vim/bundle/vim-endwise" ] && \
    git clone git://github.com/tpope/vim-endwise.git $HOME/.vim/bundle/vim-endwise

[ ! -d "$HOME/.vim/bundle/vim-fugitive" ] && \
    git clone git://github.com/tpope/vim-fugitive.git $HOME/.vim/bundle/vim-fugitive

[ ! -d "$HOME/.vim/bundle/vim-mustache-handlebars" ] && \
    git clone git://github.com/mustache/vim-mustache-handlebars.git $HOME/.vim/bundle/vim-mustache-handlebars

[ ! -d "$HOME/.vim/bundle/vim-projectionist" ] && \
    git clone git://github.com/tpope/vim-projectionist.git $HOME/.vim/bundle/vim-projectionist

[ ! -d "$HOME/.vim/bundle/vim-rails" ] && \
    git clone git://github.com/tpope/vim-rails.git $HOME/.vim/bundle/vim-rails

[ ! -d "$HOME/.vim/bundle/vim-repeat" ] && \
    git clone git://github.com/tpope/vim-repeat.git $HOME/.vim/bundle/vim-repeat

[ ! -d "$HOME/.vim/bundle/vim-ruby" ] && \
    git clone git://github.com/vim-ruby/vim-ruby.git $HOME/.vim/bundle/vim-ruby

[ ! -d "$HOME/.vim/bundle/vim-surround" ] && \
    git clone git://github.com/tpope/vim-surround.git $HOME/.vim/bundle/vim-surround

[ ! -d "$HOME/.vim/bundle/vim-unimpaired" ] && \
    git clone git://github.com/tpope/vim-unimpaired.git $HOME/.vim/bundle/vim-unimpaired
