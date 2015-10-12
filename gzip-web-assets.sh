#!/usr/bin/env bash

for file in $(find . -type f -depth 1 | egrep "\.(css|js|eot|svg|ttf)$") ; do
  gzip -c --best $file > $file.gz
done
