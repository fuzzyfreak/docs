#!/bin/bash

source scriptVars.sh
source scriptFunc.sh
source fileFunc.sh

clear

while :
do
    echo "---==MainMenu==---"
    echo " * 1: File Menu: "
    echo " * quit: Exit!"
    read OPT1

    case $OPT1 in
        1) file_menu ;;
        quit) exit_fun ;;
    esac

read -p "Press any key to continue... " -n1 -s
    clear
done
