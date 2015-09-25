#!/bin/sh
# Simple worklog functions so I can keep notes and search them later

# Where to keep the worklog
WORKLOG_FILE=$HOME/worklog.txt

#   Appends input to the end of a worklog.txt file with a timestamp in
#   front of the line, allowing for easy search by date/time
function wl() {
  echo $(date + "[%Y/%m/%d %T %z] ") $* >> $WORKLOG_FILE
}

function l() {
  LINE_COUNT=$1
  [ -z "$1" ] && LINE_COUNT=10
  tail -n $LINE_COUNT $WORKLOG_FILE
}

# Quick search the worklog with grep
# Use
#   Search for add in worklog
#     $ q add
#   Search for add case insensitive
#     $ q -i add
#   Search for lines containing add or json
#     $ q -E 'add|json'
#   Search for lines with add or json and 
#   include 3 lines of context before and after
#     $ q -E -A3 -B3 'add|json'
function q() {
  ARGS=$*
  if [ -n "$ARGS" ]; then
      grep $ARGS $WORKLOG_FILE
  fi
}
