#!/bin/bash

source includes/scriptVars.sh
source includes/scriptFunc.sh


#GAFILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -mmin +1 -print)"
#GAFILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -print | awk '{ print substr($1,25); }')"
GAFILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -printf '%T@ %p\n' )"
#find -maxdepth 1 -type f -printf '%T@ %p\n' \
#  | sort -k1,1 -g | head -20 | sed 's/^[0-9.]\+ //' \
#  | xargs echo mv -t dest_dir


AFILE=$GAFILE
#echo $AFILE

for i in $AFILE
do
    echo $i
done

$TESTVAR
