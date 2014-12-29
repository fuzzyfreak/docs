#!/bin/bash

server_start()
{
    #echo $JAVA
cd /home/minecraft/servers/minecraft/yogscastCompletePlus/

    if [ -z "$JAVA" ]; then
        screen -dms minecraft java -Xms6144m -Xmx14336m -XX:PermSize=256m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled -XX:ParallelGCThreads=3 -jar cauldron-1.6.4-1.965.21.204-server.jar nogui
        #echo $JAVA
    else
        echo "Java running on $JAVA!"
        #echo $REEN
    fi
}

java_checker()
{
    if [ -z "$JAVA" ]; then
        echo "Java NOT running!"
    else
        echo "Jave running on PID $JAVA!"
    fi
}

screen_checker()
{
    if [ -z "$REEN" ]; then
        echo "Screen NOT running...WIP"
    else
        echo "Screen running name: $REEN"
    fi
}

server_stop()
{
    if [ -z "$REEN" ]; then
        echo "Screen NOT running...!"
    else
        screen -S $REEN -X stuff "stop $(printf \\r)"
    fi
}

exit_fun()
{
    echo "Bye!"; clear; exit
}

server_menu()
{
    while :
    do
        echo "Server running on PID "$JAVA"!"
        echo "Screen name is ... $REEN"
        echo "---==FileMenu==---"
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
