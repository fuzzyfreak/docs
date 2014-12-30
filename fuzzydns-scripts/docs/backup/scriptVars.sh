#!/bin/bash

# $SSHSTUFF and $PF still work but no longer used
#SSHSTUFF="ssh -p 8989 192.168.1.101 screen -S minecraft -X stuff"
#PF=" $(printf '\r')\""

RSOURCE="/home/minecraft/mnt/nfs/minecraft/servers/minecraft/yogscastCompletePlus"
RDEST="/home/minecraft/backups/"
CPDEST="/home/minecraft/mnt/nfs/backup"
CPSOURCE="/home/minecraft/backups/"
TSOURCE="/home/minecraft/backups"
GAFILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -print)"
G12FILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -mmin +720 -print)"
G24FILE="$(find $CPDEST/*tar.gz -maxdepth 1 -mtime +2 -print)"
MCFON="/home/minecraft/mnt/nfs/minecraft"
NOW=$(date +%Y-%m-%d.%H:%M:%S)
EFROM="constraft@gmail.com"
SMTP="smtp.gmail.com:587"
ETO="fuzzyheadedfreak@gmail.com"
EPASS="a5c6d7f8z9"
FL="fuzzylog"
ESEND="sendemail -f constraft@gmail.com -s smtp.gmail.com:587 -xu constraft@gmail.com -xp a5c6d7f8z9 -t fuzzyheadedfreak@gmail.com -o tls=yes -m "
