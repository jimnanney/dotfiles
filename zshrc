# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(tmuxinator git rbenv web-search fasd)
ulimit -n 2048

#eval "$(rbenv init -)"
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
alias emacs="/usr/local/Cellar/emacs/24.5/Emacs.app/Contents/MacOS/Emacs -nw"
alias jsc=/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc

# alias stmux for shared tmux sessions
alias mux=tmuxinator
alias stmux='tmux -S /usr/local/tmux/'
alias stls='ls /usr/local/tmux'
alias c='cd ~/code'
alias blog='cd ~/code/octopress'
alias ex='cd /Users/jimnanney/code/ruby/exercism/ruby'
alias gs='git status --short'
alias ga='git add -A'
alias gc='git commit'
alias gl='git log -n 1'
alias gvim='vim'
alias serve='python -m SimpleHttpServer 8000'
alias pgstart='pg_ctl -D /usr/local/var/postgres start'

function bp {
if (( $# == 0 )) then
    cd ~/code/octopress
else
    cd ~/code/octopress
    rake new_post\["$*"\]
fi
}

export EDITOR=/usr/local/bin/vim

#export JAVA_HOME=$(/usr/libexec/java_home)
#export M2_HOME=$HOME/.maven
#export M2=$M2_HOME/bin
#export ANT_HOME=$HOME/apache-ant-1.8.3
#export PATH=$PATH:$M2:$ANT_HOME/bin
#export PATH=/usr/bin:/bin:/usr/sbin:/sbin


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
#export RUBYOPT='-W:no-deprecated -W:no-experimental'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
