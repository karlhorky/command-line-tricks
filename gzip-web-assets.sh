#!/usr/bin/env bash

# Usage:
# $ ./gzip-web-assets.sh

mkdir gzipped
for file in $(find . -type f -depth 1 | egrep "\.(css|js|eot|svg|ttf)$") ; do
  gzip -c --best $file > gzipped/$file
done
