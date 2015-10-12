#!/usr/bin/env bash

for file in *.{css,js,eot,svg,ttf} ; do
  gzip -c --best $file > $file.gz
done
