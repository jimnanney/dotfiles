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

CWD=$(pwd)
CD $HOME
source $HOME/.tools/proxy.sh
rm .gemrc .gitconfig .gitignore_global .npmrc .railsrc .tmux.conf \
  .vimrc .yarnrc .zshrc .zshenv
rm /Users/$USER/Library/Application\ Support/Google/Chrome/Default/Bookmarks

# install oh-my-zsh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install brew packages
if [ "$(which brew)" ]; then
  brew install ctags fzf nvm neovim postgresql@11 rbenv ruby-build ripgrep \
    tmux vim gh
fi

TOOLS=$HOME/.tools
ln -s $TOOLS/bin $HOME/bin
ln -s $TOOLS/.gemrc $HOME/.gemrc
ln -s $TOOLS/.gitconfig $HOME/.gitconfig
ln -s $TOOLS/.gitignore_global $HOME/.gitignore_global
ln -s $TOOLS/.npmrc $HOME/.npmrc
ln -s $TOOLS/.railsrc $HOME/.railsrc
ln -s $TOOLS/.tmux.conf $HOME/.tmux.conf
ln -s $TOOLS/.vim $HOME/.vim
ln -s $TOOLS/.vimrc $HOME/.vimrc
ln -s $TOOLS/.yarnrc $HOME/.yarnrc
ln -s $TOOLS/.zshrc $HOME/.zshrc
ln -s $TOOLS/.zshenv $HOME/.zshenv
ln -s $TOOLS/jimnanney.zsh-theme $HOME/.oh-my-zsh/custom/jimnanney.zsh-theme
ln -s $TOOLS/Bookmarks /Users/$USER/Library/Application\ Support/Google/Chrome/Default/Bookmarks

# Setup my vim plugins
mkdir -p $HOME/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# download terminal colorscheme
git clone git://github.com/stephenway/monokai.terminal.git $HOME/monokai.terminal

export RUBY_MAKE_OPTS="-j 1"
rbenv install 3.1.2
rbenv global 3.1.2

gem install bundler
gem install tmuxinator
gem install neovim
cd $CWD

