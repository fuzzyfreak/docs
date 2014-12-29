#!/bin/bash

source scriptVars.sh
source scriptFunc.sh

FIND=`find $TSOURCE/*tar.gz -maxdepth 1 -mmin +1 -print`

for i in `find $TSOURCE/*tar.gz -maxdepth 1 -type f | wc -l`
do
    echo "file $i"
done
