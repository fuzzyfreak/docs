#!/bin/bash

NOW=$(date +%Y-%m-%d.%H:%M:%S)
CSOU="/home/minecraft/docs/count"
SSOU="/home/minecraft/docs/count/stuff"

if [ -d $CSOU ]
then
    cd $CSOU
      if [ -d $SSOU ]
      then
        
else
    mkdir $CSOU
fi


#mkdir count
cd $CSOU
#mkdir stuff

echo $NOW

for i in 1 2 3 4 5 6 
do
	echo $i
done

if [ -d stuff_$NOW ]
then
    for i in 1 2 3 4 5 6
    do
        if [ -d stuff_$NOW -$i ]
	then
	    continue
	else
	    cp -r stuff stuff_$NOW -$i
	    break
	fi
    done
else
    cp -r stuff stuff_$NOW
fi
