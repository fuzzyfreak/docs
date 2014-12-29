#!/bin/bash

source serverFunc.sh

JAVA=""
REEN=""
RUNL=""

NIU()
{
if ps aux | grep "screen" > /dev/null; then
    echo "Screen is running!"
else
    echo "Screen NOT running!"
fi
}

psvar_checker()
{
echo $JAVA
echo $REEN
echo $RUNL
}

ps_get()
{
    JAVA="$(pidof java)"
    REEN="$(pidof screen)"
    RUNL="$(pidof auto-start.sh)"
}

ps_java()
{
    JAVA="$(pidof java)"
}

server_start
