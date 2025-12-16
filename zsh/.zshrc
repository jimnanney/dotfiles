# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export SHELL=$(which zsh)
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME="jimnanney"
ZSH_THEME="jimnanney"

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
ulimit -n 2048
plugins=(fzf git tmuxinator rbenv web-search zsh-autosuggestions)
source ~/.config/zsh/init-loader.sh
ZSH_WEB_SEARCH_ENGINES=(
    ghe      "https://git.uscis.dhs.gov/search?q="
    rgems    "https://rubygems.org/search?query="
)
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi

source $ZSH/oh-my-zsh.sh

alias c='cd ~/workspace'
alias gs='git status --short'
alias ga='git add -A'
alias gc='git commit'
alias gl='git log -n 1'

export EDITOR=$(which nvim)

# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export LDFLAGS="-L$(brew --prefix postgresql@15)/lib"
export CPPFLAGS="-I$(brew --prefix postgresql@15)/include"
export PKG_CONFIG_PATH="$(brew --prefix postgresql@15)/lib/pkgconfig"
export PATH="$(brew --prefix)/bin:$(brew --prefix postgresql@15)/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/bin"
#export PATH="/usr/local/opt/curl/bin:$PATH"
#export HOMEBREW_FORCE_BREWED_CURL=1
export RUBY_MAKE_OPTS="-j 1"
# for autodetecting the Gemfile in the current or parent directories
# export RUBYGEMS_GEMDEPS=-
export DISABLE_SPRING=true
export GH_HOST='git.uscis.dhs.gov'
export LESSOPEN="lessopen.sh %s"
export LESSclose="lessclose.sh %s %s"
export KUBECONFIG=$HOME/.kubeconfig-prod
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"
source <(fzf --zsh)
source ~/.env
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
