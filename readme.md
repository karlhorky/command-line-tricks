# Command Line Tricks

A collection of useful command line tricks

## Create File with Content

To create a file including content (overwriting the file if it exists), use `echo` with the `-e` flag (to allow for escape sequences like the `\n` newline) and redirect to a file with `>`:

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

## Set zsh custom tab title

To set a custom terminal tab title with zsh, configure [the zsh `precmd` and `preexec` hook functions](https://zsh.sourceforge.io/Doc/Release/Functions.html#Hook-Functions) in `.zshrc`:

`~/.zshrc`

```bash
# Disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
function precmd () {
  echo -ne "\033]0;Custom title: $(print -rD $PWD)\007"
}
precmd

function preexec () {
  print -Pn "\e]0;🚀 $(print -rD $PWD) $1 🚀\a"
}
```

This will change the tab title as such:

1. Show the `Custom title:` prefix before the present working directory
2. When a foreground program is running, rocket emojis will appear at the beginning and end of the prompt to show a visual indicator that something is running

https://github.com/user-attachments/assets/535b243c-3f4b-4b85-8a96-d1766ab8d000

To use this with [Ghostty](https://ghostty.org/), disable Ghostty's built-in shell integration using [`shell-integration-features = no-title`](https://ghostty.org/docs/config/reference#shell-integration-features):

`~/Library/Application Support/com.mitchellh.ghostty/config`

```ini
# Disable Ghostty built-in tab title shell integration
# https://ghostty.org/docs/config/reference#shell-integration-features
shell-integration-features = no-title
```

## Wrap command and exit based on stdout

To wrap a command and exit based on stdout from the command, loop over each line of the stdout to look for the message. If the message is found, set a variable to `true` and exit with code `1`:

```bash
pnpm install | { has_ignored_build_scripts=false; while IFS= read -r line; do echo "$line"; [[ "$line" == *"Ignored build scripts:"* ]] && has_ignored_build_scripts=true; done; [[ "$has_ignored_build_scripts" = false ]]; }
```

Source: [Fail `pnpm install` on pnpm v10 ignored build scripts](https://github.com/karlhorky/pnpm-tricks#fail-pnpm-install-on-pnpm-v10-ignored-build-scripts)
