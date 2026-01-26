ulimit -n 2048
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
export SHELL=$(which zsh)
# Set name of the theme to load.
ZSH_THEME="jimnanney"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(fzf fzf-tab git tmuxinator rbenv web-search zsh-autosuggestions)
source ~/.config/zsh/init-loader.sh
ZSH_WEB_SEARCH_ENGINES=(
    ghe      "https://git.uscis.dhs.gov/search?q="
    rgems    "https://rubygems.org/search?query="
)
# EXTENDED_GLOB Treat the `#', `~' and `^' characters as part of patterns for filename generation, etc
#
# NULL_GLOB If a pattern for filename generation has no matches, delete the pattern from the argument list
# instead of reporting an error
setopt EXTENDED_GLOB NULL_GLOB

export HISTSIZE=100000
export SAVESTSIZE=100000
export HISTFILE=$HOME/.zsh_history

# HIST_IGNORE_DUPS Do not enter command lines into the history list if they are duplicates of the previous event.
#
# HIST_IGNORE_SPACE Remove command lines from the history list when the first character on the line is a space,
# or when one of the expanded aliases contains a leading space
#
# SHARE_HISTORY This option both imports new commands from the history file, and also causes your typed commands
# to be appended to the history fil
setopt EXTENDED_HISTORY HIST_IGNORE_DUPS SHARE_HISTORY

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
fi

source $ZSH/oh-my-zsh.sh

alias c='cd ~/workspace'
alias gs='git status --short'
alias ga='git add -A'
alias gc='git commit'
alias gl='git log -n 1'

export EDITOR=$(which nvim)
export VISUAL=$(which nvim)

export HOMEBREW_PREFIX=$(brew --prefix)
export LDFLAGS="-L$(brew --prefix postgresql@15)/lib"
export CPPFLAGS="-I$(brew --prefix postgresql@15)/include"
export PKG_CONFIG_PATH="$(brew --prefix postgresql@15)/lib/pkgconfig"
export PATH="$HOMEBREW_PREFIX/bin:$(brew --prefix postgresql@15)/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH:$HOME/bin"
# export RUBY_MAKE_OPTS="-j 1"
# older rails used SPRING - I don't like it ;)
export DISABLE_SPRING=true
export LESSOPEN="lessopen.sh %s"
export LESSCLOSE="lessclose.sh %s %s"
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"
source <(fzf --zsh)
source ~/.env
# kubernetes
export KUBECONFIG=$HOME/.kubeconfig-prod
which kubectl >/dev/null && source <(kubectl completion zsh)
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

