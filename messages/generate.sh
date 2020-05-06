#!/bin/bash

for i in $(ls *.po)
do
  language=$(echo $i | sed -e 's/^bingada-//' -e 's/\.po//');
  echo $language
  if [ ! -d $language/LC_MESSAGES ]
  then
    mkdir -p $language/LC_MESSAGES
  fi
  msgfmt $i -o $language/LC_MESSAGES/bingada.mo
done
