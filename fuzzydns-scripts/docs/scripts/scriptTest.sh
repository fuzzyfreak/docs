#!/bin/bash

# This is the place to test stuff!

SAYME="say test"

file_fun()
{
    while :
    do
        echo "This is a new menu called like a function!"
        echo " * 1: List files in $CPSOURCE!"
        echo " * 2: Something from same fuction!"
        echo " * 3: Server shutdown test!"
        echo " * 4: Server start test!"
        echo " * 5: say test"
        echo " * quit: Exit!"
        read OPT2

        case $OPT2 in
            1) file_list 1 ;;
            2) file_list 2 ;;
            3) server_control 1 ;;
            4) server_control 2 ;;
            5) say_this $SAYME ;;
            quit) break ;;
        esac

read -p "Press any key to continue... " -n1 -s
        clear
    done
}


file_list()
{
    case $1 in
        1) ls -la $CPSOURCE; break ;;
        2) pwd; break ;;
    esac
}

server_control()
{
    case $1 in
        1) $SSHSTUFF \"say Server shutingdown $PF; save_off; $SSHSTUFF \"stop $PF; break ;;
        2) ssh -p 8989 192.168.1.101 'sh runloop.sh'
    esac
}

say_this()
{
    $SSHSTUFF \""$1" $PF
}
