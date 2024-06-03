# Command Line Tricks

A collection of useful command line tricks

## FFmpeg: Combine two video files

Combine two video files using [FFmpeg](https://ffmpeg.org/)

```bash
ls video1.mp4 video2.mp4 | while read line; do echo file \'$line\'; done | ffmpeg -protocol_whitelist file,pipe -f concat -i - -c copy output.mp4
```

Source: [How to concatenate two MP4 files using FFmpeg? (Answer) | Stack Overflow](https://stackoverflow.com/a/61151377/1268612)

## gzip web assets

Loop over CSS, JS, EOT, SVG and TTF files and gzip them into a folder named `gzipped`.

[gzip-web-assets.sh](https://github.com/karlhorky/command-line-tricks/blob/master/gzip-web-assets.sh)

## Find and Replace in Git Remote

Sometimes you may want to search and replace within your Git remote - for example, if you change your username on GitHub. This is a command to do it (replaces `OldUsername` with `NewUsername`):

```sh
git remote set-url origin $(current_origin=$(git remote get-url origin --push) && echo ${current_origin/OldUsername/NewUsername})
```
