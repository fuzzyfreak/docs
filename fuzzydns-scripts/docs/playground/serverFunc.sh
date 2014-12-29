#!/bin/bash

server_start()
{
    echo $JAVA

    if [ -z "$JAVA" ]; then
        screen -dms minecraft java -Xms6144m -Xmx14336m -XX:PermSize=256m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled -XX:ParallelGCThreads=3 -jar cauldron-1.6.4-1.965.21.204-server.jar nogui
        echo $JAVA
    else
        echo "Java running on $JAVA!"
        echo $REEN
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
        echo "Screen NOT running...WIP!"
    else
        echo "Screen running name: $REEN!"
    fi
}

server_stop()
{
    if [ -z "$REEN" ]; then
        echo "Screen NOT running...!"
    else
        screen -S $REEN -X stuff "save-all $(print \\r)"
    fi
}
