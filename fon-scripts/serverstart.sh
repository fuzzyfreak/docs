#!/bin/bash

source mainmenu.sh
source serverFunc.sh

JAVA="$(pidof java)"
REEN="$(screen -ls | awk 'FNR == 2 { print $1 }')"

while [ $# -gt 0 ]
do
    case "$1" in
        -h | --help) echo "-h --help help"\n
                     echo "-m --menu main menu"\n
                     echo "-s --start starts server" ;;
        -m | --menu) main_menu ;;
        -s | --start) server_start ;;
    esac
    shift
done
