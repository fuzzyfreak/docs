#!/bin/bash

source scriptVars.sh
source scriptFunc.sh

function usage
{
    echo "usage: system_page [[[-f file ] [-i]] | [-h]]"
}

#$SSHSTUFF \"say test $PF

say_this()
{
    if [ "$1" = "1" ]; then
        $SSHSTUFF \"say test 1 $PF
    if [ "$1" = "2" ]; then
        $SSHSTUFF \"say test 2 $PF
    fi
    fi
}

#say_this 1

if [ $# -gt 0 ]; then
    echo "args $#"
else
    echo "none"
fi

INTERACTIVE=
FILENAME=~/system_page.html

while [ "$1" != "" ]; do
    case $1 in
        -f | --file )           shift
                                FILENAME=$1
                                ;;
        -i | --interactive )    INTERACTIVE=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

# Test code to verify command line processing

if [ "$INTERACTIVE" = "1" ]; then
	echo "interactive is on"
else
	echo "interactive is off"
fi
echo "output file = $FILENAME"


# Write page (comment out until testing is complete)

# write_page > $FILENAME



if [ "$INTERACTIVE" = "1" ]; then

    RESPONSE=

    echo -n "Enter name of output file [$FILENAME] > "
    read RESPONSE
    if [ -n "$RESPONSE" ]; then
        filename=$RESPONSE
    fi

    if [ -f $FILENAME ]; then
        echo -n "Output file exists. Overwrite? (y/n) > "
        read RESPONSE
        if [ "$RESPONSE" != "y" ]; then
            echo "Exiting program."
            exit 1
        fi
    fi
fi


