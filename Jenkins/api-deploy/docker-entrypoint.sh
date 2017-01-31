#!/bin/bash

function confirm_or_exit
{
  local prompt=$1
  local answer

  local yn=""
  echo
  while [ ! $yn ]
  do
    read -p "$prompt (y/n)? " answer
     case $answer in
         [yY] ) yn='y'; break;;
         [nN] ) yn='n'; break;;
     esac
  done

  if [ $yn != 'y' ]; then exit_cleanly; fi
}

confirm_or_exit "Do you want to exit?"

echo "well done"

exit 0
