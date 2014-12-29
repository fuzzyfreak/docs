#!/bin/bash

while true
do
    java -Xms6144m -Xmx14336m -XX:PermSize=256m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSParallelRemarkEnabled -XX:ParallelGCThreads=3 -jar cauldron-1.6.4-1.965.21.204-server.jar nogui
    echo "If you want to completely stop the server process now, press Ctrl+C before the time is up!"
    echo "Rebooting in:"
    for i in 5 4 3 2 1
    do
        echo "$i..."
        sleep 1
    done
    echo "Rebooting now!"
done
