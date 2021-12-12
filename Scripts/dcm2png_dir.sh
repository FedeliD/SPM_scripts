#!/usr/bin/env bash
#for d in /*; do
#  cd $d
#  echo " converting files in $d directory"
    for f in *; do
      dcmj2pnm "$f" "$f.png" +on
    done
#done
