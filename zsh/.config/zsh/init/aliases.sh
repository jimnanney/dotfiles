#!/bin/sh

# Aliases that don't belong to a particular tool
#alias ls='ls -G'
#alias pkssh='ssh -I /usr/local/lib/opensc-pkcs11.so'
# To migrate existing data from a previous major version of PostgreSQL run:
#   brew postgresql-upgrade-database
#
# To have launchd start postgresql now and restart at login:
#   brew services start postgresql
# Or, if you don't want/need a background service you can just run:
#   pg_ctl -D /usr/local/var/postgres start
#
#export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
#alias pgstart='pg_ctl -D /usr/local/var/postgresql@11 start'

# To have launchd start redis now and restart at login:
#  brew services start redis
# Or, if you don't want/need a background service you can just run:
#  redis-server /usr/local/etc/redis.conf
#alias start-redis='redis-server /usr/local/etc/redis.conf'
alias be='bundle exec'

alias gtcl='FROM=$(git tag --sort=-creatordate|head -2|tail -1) TO=$(git tag --sort=-creatordate|head -1) && git log --oneline --decorate --no-merges ${FROM}..${TO}'
alias gtclc='FROM=$(git tag --sort=-creatordate|head -2|tail -1) TO=$(git tag --sort=-creatordate|head -1) && git log --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --no-merges ${FROM}..${TO}'

#alias zoo='zookeeper-server-start /usr/local/Cellar/kafka/2.2.0/.bottle/etc/kafka/zookeeper.properties'
#alias kfk='kafka-server-start /usr/local/Cellar/kafka/2.2.0/.bottle/etc/kafka/server.properties'
alias mig='bundle exec rake db:{migrate,test:prepare} && git checkout db/structure.sql'
alias ri='ri -f ansi'
alias gs='git status --short'
alias ga='git add -A'
alias gc='git commit'
alias gl='git log -n 1'
alias glog='git log --oneline --decorate --graph'
alias ls='ls -G'
alias mywork="jira issue jql '\"assignee\" = \"james.a.nanney@uscis.dhs.gov\" OR \"Assigned To:\"  = \"james.a.nanney@uscis.dhs.gov\" OR \"Secondary Assignee\" = \"james.a.nanney@uscis.dhs.gov\" AND status in (\"Ready for Work\", \"In Testing\", \"Ready for Release\", \"In Progress/Development\")'"
#alias rfw="jira issue jql 'status = \"Ready for Work\" AND component = \"Global Checkers\" ORDER BY Rank'"
alias upcoming="jira issue jql 'status = \"Ready to Size\" AND component = \"Global Checkers\" ORDER BY Rank'"
alias rfw="curl -G -H "Authorization: Bearer $JIRA_TOKEN" --data-urlencode 'fields=summary,description' --data-urlencode 'jql=project = DIDIT AND component = \"Global Security Checks\" and status in (\"Ready for Work\")' \"$JIRA_API_HOST/jira/rest/api/2/search\"|jq ."
