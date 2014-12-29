#!/bin/bash

echo "$(free -m)" >> testlog.txt
echo "$(df -h /)" >> testlog.txt
echo "$(df -h /home)"
