#!/usr/bin/env bash


#---------
#Combined less and ls command.
#---------

# TODO: Support multiple files.

# $1 = lss filename
lss() {
  # last arg is file
  FILE=${@: -1}
  if [ -f "$FILE" ]; then
    less $@
  else
    ls $@
  fi
}

if [[ $BASH_SOURCE[0] != $0 ]]; then
  export -f lss
else
  lss "${@}"
  exit $?
fi
