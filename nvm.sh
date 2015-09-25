#!/bin/sh
CURRENT_NODE_VERSION=4.0.0

if [ -d "$HOME/.nvm" ]; then
    $HOME/.nvm/nvm.sh
    nvm use $CURRENT_NODE_VERSION
fi
