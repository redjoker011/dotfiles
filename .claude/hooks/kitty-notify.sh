#!/bin/sh
# Hooks run without a controlling terminal, so `kitten notify` can't open /dev/tty.
# Walk up to the first ancestor with a tty (the claude process) and write kitty's
# OSC 99 desktop-notification escape there directly.
p=$$
while [ "$p" -gt 1 ]; do
  t=$(ps -o tty= -p "$p" | tr -d ' ')
  case "$t" in ''|'??') ;; *) break ;; esac
  p=$(ps -o ppid= -p "$p" | tr -d ' ')
done
[ "$p" -gt 1 ] || exit 0
printf '\033]99;i=cc:d=0:o=always;Claude Code\033\\\033]99;i=cc:d=1:p=body;%s\033\\' "${1:-Done}" > "/dev/$t"
