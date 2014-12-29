#!/bin/bash

file_fun()
{
    while :
    do
        echo "Server running on PID "$JAVA"!"
        echo "Screen name is "$REEN"!"
        echo "This is a new menu called like a function!"
        echo " * 1: Server start!"
        echo " * 2: Java check!"
        echo " * 3: Screen check!"
        echo " * 4: Server stop!"
        echo " * 5: say test"
        echo " * quit: Exit!"
        read OPT1

        case $OPT1 in
            1) server_start ;;
            2) java_checker ;;
            3) screen_checker ;;
            4) server_stop ;;
            5) echo "nothing here" ;;
            quit) break ;;
        esac

read -p "Press any key to continue... " -n1 -s
        clear
    done
}
