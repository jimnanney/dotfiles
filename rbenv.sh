#!/bin/sh

# Initialize rbenv if it is available
if [ -d $HOME/.rbenv/bin]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
    export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi
