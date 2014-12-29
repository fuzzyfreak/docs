#!/bin/bash

source scriptVars.sh
source scriptFunc.sh

echo $NOW

clear_log
server_checker
cat $TSOURCE/$FL
