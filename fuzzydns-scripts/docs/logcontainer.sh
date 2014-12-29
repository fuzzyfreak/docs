#!/bin/bash

source scriptVars.sh
source scriptFunc.sh



# Get screen name over ssh and set
REEN=""

get_reen()
{
    if [ -n "$REEN" ]; then
        echo "Getting screen name!"
        REEN="$(ssh -p 8989 192.168.1.101 screen -ls | awk 'NR==2 {print $1}')"
    else
        echo "Screen not running!"
    fi
}

echo "$REEN before get"
get_reen
echo "$REEN after get"
