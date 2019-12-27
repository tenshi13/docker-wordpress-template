#! /bin/sh

# should really check if requirements are installed
# we are doing wp, so at the very least we need php
# ok we want it to be at least php7 also :D

if ! [ -x "$(command -v php)" ]; then
  echo 'Error: php is not installed.' >&2
  exit 1
fi

PHP_VERSION=$(php -v | tail -r | tail -n 1 | cut -d " " -f 2 | cut -c 1)
if (( $(echo "$PHP_VERSION < 7" |bc -l) )); then
  echo 'Error: php need to be version 7 and above, please update.'
  exit 1
fi
