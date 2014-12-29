#!/bin/bash

source scriptVars.sh
source scriptFunc.sh

clear

while :
do
    printf "%s\n" "#####Welcome#####" "This will serve" "as a tool menu" "for admin stuff" 
    echo "Select an option."
    echo " * 1: Server Checker"
    echo " * 2: rsync"
    echo " * 3: tar"
    echo " * 4: Save off to rsync!"
    echo " * 5: Save on!"
    echo " * 6: Test this may not work!"
    echo " * 7: Exit"
    read OPT1

    case $OPT1 in
        1) server_checker ;;
        2) rsync_fun ;;
        3) tar_fun ;;
        4) save_off ;;
        5) save_on ;;
        6) test_fun ;;
        7) exit_fun ;;
    esac

read -p "press any key to continue... " -n1 -s

    clear
done
