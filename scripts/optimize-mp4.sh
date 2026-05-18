#!/bin/sh
set -e
in="$1"
out="${2:-$1}"
if [ -z "$in" ]; then
  echo "Usage: optimize-mp4.sh input.mp4 [output.mp4]" >&2
  exit 1
fi
if [ "$in" = "$out" ]; then
  tmp="${in}.faststart.tmp.mp4"
  ffmpeg -y -i "$in" -c copy -movflags +faststart "$tmp"
  mv "$tmp" "$in"
else
  ffmpeg -y -i "$in" -c copy -movflags +faststart "$out"
fi
