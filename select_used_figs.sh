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
  allFiles=`grep "<$figs/" $log`
  allFiles=${allFiles//<$figs\//}
  allFiles=${allFiles//>/}

  # getting every file name only once (not really necessary in principle...)
  files="makefile"
  for f in $allFiles; do
    if [ "${files//$f/}" = "$files" ]; then
      files="$files $f"
    fi
  done
  # sort list of files alphabetically
  files=`echo -e "${files// /\n}" | sort`
  # files=${files//\n/ }
  echo -e "\nList of files I will keep:"
  echo $files

  # processing figs folder and deleting unused files
  mkdir -p ${figs}-unused
  cd $figs
  for f in *; do
    if [ "${files//$f/}" = "$files" ]; then
      echo " moving  - $f"
      mv $f ../${figs}-unused
    else
      echo " keeping + $f"
    fi
  done

  echo -e "\nDone."
else
  echo -e "\nDirectory $figs does not exist!\nEnding now..."
  exit
fi
