#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Wrong usage!!!"
  echo -e "I need 1 argument, which is the log-file after LaTeX run.\n"
  echo "Currently available file(s):"
  ls *.log
  echo -e "\nEnding..."
  exit 1
fi
log=$1

figs="figs"
if [ $# -gt 1 ]; then
  figs=${2%/}
fi

if [ ! -f "$log" ]; then
  echo -e "\nLog-file $log does not exist!\nEnding now..."
  exit 1
fi

if [ ! -d "$figs" ]; then
  echo -e "\nDirectory $figs does not exist!\nEnding now..."
  exit 1
fi

echo "I am going to move all files from directory ./$figs to ./${figs}-unused,"
echo "which are not mentioned in the LaTeX log-file: $log."

# getting file list
# TeX wraps log lines at 79 characters, so join wrapped lines first;
# the .fls file (written by latexmk, or with -recorder) is never wrapped
fls="${log%.log}.fls"
[ -f "$fls" ] || fls=/dev/null
allFiles=$( { awk '{ printf "%s", $0; if (length($0) != 79) print "" }' "$log"; cat "$fls"; } \
  | grep -oE "(^|[^A-Za-z0-9_.-])${figs}/[^ ,<>(){}\"']+" \
  | sed -E "s|^[^A-Za-z0-9_.-]?${figs}/||" )

# start with makefile, then add each file exactly once, sorted alphabetically
mapfile -t files < <( { echo "makefile"; [ -n "$allFiles" ] && echo "$allFiles"; } | sort -u )

if [ ${#files[@]} -le 1 ]; then
  echo -e "\nNo files from $figs/ found in $log - refusing to move everything."
  echo "Ending now..."
  exit 1
fi

echo -e "\nList of files I will keep:"
printf '%s\n' "${files[@]}"

# processing figs folder and moving unused files
mkdir -p "${figs}-unused"
cd "$figs" || exit 1

shopt -s globstar   # enables ** to match recursively
shopt -s dotglob    # optional: include dotfiles too, if relevant

for f in **/*; do
  [ -d "$f" ] && continue    # skip directories, only handle files

  keep=0
  for kept in "${files[@]}"; do
    if [ "$kept" = "$f" ]; then
      keep=1
      break
    fi
  done
  if [ "$keep" -eq 0 ]; then
    echo " moving  - $f"
    mkdir -p "../${figs}-unused/$(dirname "$f")"
    mv -- "$f" "../${figs}-unused/$f"
  else
    echo " keeping + $f"
  fi
done

echo -e "\nDone."
