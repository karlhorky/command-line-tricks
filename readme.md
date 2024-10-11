# Command Line Tricks

A collection of useful command line tricks

## Create File with Content

To create a file including content (overwriting any existing file), use `echo` with the `-e` flag (to allow for escape sequences like the `\n` newline) and redirect to a file with `>`:

```bash
echo -e 'abc\ndef' > 1.txt
```

Now `1.txt` will include the following content:

```
abc
def
```

To make multi-line content more readable, use `cat` with a heredoc tag like `EOF`:

```bash
cat << EOF > main.ts
import { add } from './add.js';

console.log(add(2,3));
EOF
```

## FFmpeg: Combine two video files

Combine two video files using [FFmpeg](https://ffmpeg.org/)

```bash
ls video1.mp4 video2.mp4 | while read line; do echo file \'$line\'; done | ffmpeg -protocol_whitelist file,pipe -f concat -i - -c copy output.mp4
```

Source: [How to concatenate two MP4 files using FFmpeg? (Answer) | Stack Overflow](https://stackoverflow.com/a/61151377/1268612)

## Find and Replace in Git Remote

Sometimes you may want to search and replace within your Git remote - for example, if you change your username on GitHub. This is a command to do it (replaces `OldUsername` with `NewUsername`):

```sh
git remote set-url origin $(current_origin=$(git remote get-url origin --push) && echo ${current_origin/OldUsername/NewUsername})
```

## gzip web assets

Loop over CSS, JS, EOT, SVG and TTF files and gzip them into a folder named `gzipped`.

`gzip-web-assets.sh`

```bash
#!/usr/bin/env bash

# Usage:
# $ ./gzip-web-assets.sh

mkdir gzipped
for file in $(find . -type f -depth 1 | egrep "\.(css|js|eot|svg|ttf)$") ; do
  gzip -c --best $file > gzipped/$file
done
```
