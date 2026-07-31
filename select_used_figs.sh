#!/bin/bash

echo $#

if [ $# -lt 1 ]; then
  echo "Wrong usage!!!"
  echo -e "I need 1 argument, which is the log-file after LaTeX run.\n"
  echo "Currently available file(s):"
  ls *.log
  echo -e "\nEnding..."
  exit
fi
log=$1

figs="figs"
if [ $# -gt 1 ]; then
  figs=$2
fi


echo "I am going to delete all files from directory ./$figs,"
echo "which are not mentioned in the LaTeX log-file: $log."

if [ -d $figs ]; then
  # getting file list
  allFiles=$(grep "^<.*${figs}/" "$log")

  processedFiles=()
  while IFS= read -r line; do
    # strip everything up to and including the last occurrence of "$figs/"
    entry="${line#*${figs}/}"
    entry="${entry//>/}"
    [ -n "$entry" ] && processedFiles+=("$entry")
  done <<< "$allFiles"

  # start with makefile, then add each file exactly once
  files=("makefile")
  for f in "${processedFiles[@]}"; do
    found=0
    for existing in "${files[@]}"; do
      if [ "$existing" = "$f" ]; then
        found=1
        break
      fi
    done
    [ "$found" -eq 0 ] && files+=("$f")
  done

  # sort alphabetically, newline-safe
  IFS=$'\n' files=($(sort <<< "${files[*]}"))
  unset IFS

  echo -e "\nList of files I will keep:"
  printf '%s\n' "${files[@]}"

  # processing figs folder and deleting unused files
  mkdir -p ${figs}-unused
  cd $figs
  
  shopt -s globstar   # enables ** to match recursively
  shopt -s dotglob    # optional: include dotfiles too, if relevant

  for f in **/*; do
    [ -d "$f" ] && continue    # skip directories, only handle files

    echo "$f"
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
else
  echo -e "\nDirectory $figs does not exist!\nEnding now..."
  exit
fi
