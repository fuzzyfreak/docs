#!/bin/bash

source mainmenu.sh
source serverFunc.sh

say_this()
{
    REEN="$(screen -ls | awk 'FNR == 2 { print $1 }')"
    screen -S $REEN -p 0 -X stuff "$1^M"
}

say_this "say test"
