#!/bin/sh

TOOLS=$HOME/.tools
SCRIPTS=".zshenv
.zshrc
openssl.sh
aliases.sh
config.sh
nvm.sh
rbenv.sh
tmux.conf
vimrc
worklog.sh"

for SCRIPT in $SCRIPTS do
    source $SCRIPT
done

