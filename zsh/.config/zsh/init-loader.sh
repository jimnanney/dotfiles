#!/bin/sh

for i in $(ls $HOME/.config/zsh/init/*); do
  source $i
done
# TOOLS=$HOME/.tools
# source $TOOLS/certs.sh
# source $TOOLS/vpn.sh
# source $TOOLS/aliases.sh
# source $TOOLS/config.sh
# #source $TOOLS/drf.sh
# source $TOOLS/proxy.sh
# source $TOOLS/nvm.sh
# source $TOOLS/functions.sh
# source $TOOLS/worklog.sh
# source $TOOLS/openssl.sh
# export PATH="$PATH:$HOME/bin"
# # source $TOOLS/rvm.sh
# source $TOOLS/rbenv.sh
