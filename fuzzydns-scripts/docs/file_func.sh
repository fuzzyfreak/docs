#!/bin/bash

source includes/scriptVars.sh
source includes/scriptFunc.sh


GAFILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -print)"
G12FILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -mmin +720 -print)"
G24FILE="$(find $CPDEST/*tar.gz -maxdepth 1 -mtime +2 -print)"
#GAFILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -print | awk '{ print substr($1,25); }')"
#GAFILE="$(find $TSOURCE/*tar.gz -maxdepth 1 -printf '%T@ %p\n' )"
#find -maxdepth 1 -type f -printf '%T@ %p\n' \
#  | sort -k1,1 -g | head -20 | sed 's/^[0-9.]\+ //' \
#  | xargs echo mv -t dest_dir




file_list()
{
    for i in $GAFILE; do echo "All tar files $i!"; done
}

file_copy()
{
    say_this "say Transfering files to NAS!"
    for i in $GAFILE; do echo "Files that will copy $i"; cp -n $i $CPDEST; done

        if [ "$?" -eq "0" ]; then
                echo "Transfer successfull" >> $TSOURCE/$FL
                say_this "say Transfer successfull!"
        else
                echo "Transfer failed" >> $TSOURCE/$FL
                say_this "say transfer failed!"
                send_log
                exit
        fi
}

file_delete()
{
    say_this "say Deleting files 48 hours old or more on nas!"
    for i in $G24FILE; do echo "Files 48 hours or older on nas $i"; done
        if [ "$?" -eq "0" ]; then
                echo "Delete successfull" >> $TSOURCE/$FL
                say_this "say Delete successfull!"
        else
                echo "Delete failed" >> $TSOURCE/$FL
                say_this "say Delete failed!"
                exit
        fi
}

file_delete_nas()
{
    for i in $G24FILE; do echo "Deleted on nas $i"; done
}
file_copy
