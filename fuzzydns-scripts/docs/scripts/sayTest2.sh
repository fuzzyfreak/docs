#!/bin/bash

source scriptVars.sh
source scriptFunc.sh

echo "You start with $# positional parameters"

# Loop until all parameters are used up
while [ "$1" != "" ]; do
    if [ "$1" = "1" ]; then
        echo "$1"
        $SSHSTUFF \"say test $PF
    if [ "$1" = "2" ]; then
        echo "$1"
        $SSHSTUFF \"save-off $PF
    fi
    else
        echo "Parameter 1 equals $1"
        echo "You now have $# positional parameters"

    # Shift all the parameters down by one
    fi
    shift

done
