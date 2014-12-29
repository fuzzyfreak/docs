#!/bin/bash

#source serverFunc.sh

#JAVA="$(pidof java)"
#REEN="$(screen -ls | awk 'FNR == 2 { print $1 }')"

main_menu()
{

clear

while :
do
    JAVA="$(pidof java)"
    REEN="$(screen -ls | awk 'FNR == 2 { print $1 }')"
    echo "Server running on PID "$JAVA"!"
    echo "$REEN"
    echo "---==MainMenu==---"
    echo " * 1: Server Menu: "
    echo " * quit: Exit!"
    read OPT1

    case $OPT1 in
        1) server_menu ;;
        quit) exit_fun ;;
    esac

read -p "Press any key to continue... " -n1 -s
    clear
done
}
