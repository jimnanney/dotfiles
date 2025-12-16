function force_chrome_ui_mode_light() {
  defaults write com.google.Chrome NSRequiresAquaSystemAppearance -bool Yes
}

function reset_chrome_ui_mode() {
  defaults delete com.google.Chrome NSRequiresAquaSystemAppearance
}

function ghpr() {
  GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --preview-window down | awk '{print $1}' | xargs gh pr checkout
}

function gemsource {
  INFO=$(curl -s "https://rubygems.org/api/v1/gems/$1.json")
  if [ -z "$INFO" ]; then
    echo "Gem not found"
    exit 1
  fi

  SRC=$(echo $INFO | jq -r '.source_code_uri')
  HOMEPAGE=$(echo $INFO | jq -r '.homepage_uri')
  if [ "null" != "$SRC" ]; then
    open -u $SRC
  elif [ "null" != "$HOMEPAGE" ]; then
    open -u $HOMEPAGE
  else
    echo "No URL found"
  fi
}

function ydfu-a-a-ron {
  local i SINCE COUNT
  SINCE=${1:-'1 week ago'}
  for i in $(git --no-pager log --since="$SINCE" --pretty="%h" -S '# rubocop:disable'); do
    COUNT=$(git show $i |grep '# rubocop:disable'|grep '^+'|wc -l)
    [ $COUNT -gt 0 ] && echo "$i - $COUNT - $(git show -s --pretty="%an" $i)"
  done
}

function new_cop_disables {
  local i SINCE COUNT
  SINCE=${1:-'1 week ago'}
  for i in $(git --no-pager log --since="$SINCE" --pretty="%h" -S '# rubocop:disable'); do
    DISABLES=$(git show $i |grep '# rubocop:disable')
    if [ -n "$DISABLES" ]; then
      echo "$i - $(git show -s --pretty="%an" $i)"
      echo $DISABLES
    fi
  done
}

function notify {
  [[ $# -eq 1 ]] && osascript -e "display notification \"$1\""
  [[ $# -eq 2 ]] && osascript -e "display notification \"$2\" with title \"$1\""
  [[ $# -eq 3 ]] && osascript -e "display notification \"$3\" with title \"$1\" subtitle \"$2\""
}

function repeat() {
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do
        eval "$@";
    done
}

function kill_port {
  lsof -i :$1 | awk '{l=$2} END {print l}' | xargs kill
}
