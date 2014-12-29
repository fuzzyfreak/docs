#!/bin/bash

#source includes/scriptVars.sh
#source includes/scriptFunc.sh
#source includes/scriptTest.sh


file_list()
{
    cd $TSOURCE
    for i in `find $TSOURCE/*tar.gz -maxdepth 1 -print`;do echo "$i"; done
}

file_delete()
{
    for i in `find $TSOURCE/*tar.gz -maxdepth 1 -mmin +720 -print`; do echo "Delete test $i"; done
}

file_copy()
{
    for i in `find $TSOURCE/*tar.gz -maxdepth 1 -mmin +1 -print`; do echo "Moving $i to NAS!"; cp -n $i $CPDEST; done
}

file_menu()
{
    while :
    do
        echo "---==FILES==---"
        echo " * 1: List Files."
        echo " * 2: Copy Files."
        echo " * 3: Delete Files."
        echo " * quit: Exit!"
        read OPT2

        case $OPT2 in
            1) file_list ;;
            2) file_copy ;;
            3) file_delete ;;
            quit) break ;;
        esac
read -p "Press any key to continue... " -n1 -s

    clear
    done
}
