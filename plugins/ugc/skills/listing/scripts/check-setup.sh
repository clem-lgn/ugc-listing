#!/usr/bin/env bash
# Vérifie ce dont le skill listing a besoin sur la machine. Une ligne par élément : OK / MANQUE.
# Argument : le dossier de données du plugin (où vit config.md, propre à chaque personne).
# Code de sortie 0 = tout est là, 1 = au moins un manque.
# L'extension Claude in Chrome ne se vérifie pas ici : Claude la teste lui-même.

missing=0
os="$(uname -s)"
echo "Système : $os"

if [ "$os" = "Darwin" ]; then
  if command -v brew >/dev/null 2>&1; then
    echo "OK brew"
  else
    echo "MANQUE brew"
    missing=1
  fi
fi

for tool in yt-dlp ffmpeg; do
  if command -v "$tool" >/dev/null 2>&1; then
    case "$tool" in
      yt-dlp) v="$(yt-dlp --version 2>/dev/null)" ;;
      ffmpeg) v="$(ffmpeg -version 2>/dev/null | head -1 | awk '{print $3}')" ;;
    esac
    echo "OK $tool $v"
  else
    echo "MANQUE $tool"
    missing=1
  fi
done

data_dir="$1"
if [ -z "$data_dir" ]; then
  echo "MANQUE config (dossier de données non transmis)"
  missing=1
elif [ -s "$data_dir/config.md" ]; then
  echo "OK config $data_dir/config.md"
else
  echo "MANQUE config $data_dir/config.md"
  missing=1
fi

exit $missing
