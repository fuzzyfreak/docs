#!/bin/bash

say_this()
{
    REEN="$(ssh -p 8989 192.168.1.101 screen -ls)"
    echo $REEN > log/log.txt
    AWK="$(awk 'FNR == 1 { print $6 }' log/log.txt)"
    NAME="$(echo $AWK)"
    ssh -p 8989 192.168.1.101 screen -S $NAME -p 0 -X stuff \"$1^M\"
}

say_this "say test"
say_this "say !@#$%^&*()<>?This string shouldn't work!"
