#!/bin/bash

source scriptVars.sh
source scriptFunc.sh
source scriptTest.sh

clear

while :
do
    echo "Welcome to the playground!"
    echo " * 1: test_fun"
    echo " * quit: testexit"
    read OPT1

    case $OPT1 in
        1) find_fun 1 ;;
        quit) exit_fun ;;
    esac

read -p "Press any key to continue... " -n1 -s

    clear
done
