#!/bin/bash

fdelete_nas()
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

fdelete()
{
    say_this "say Deleting files 12 hours old or less!"
    for i in $G12FILE; do echo "Files 12 hours or older on fdns $i"; done
        if [ "$?" -eq "0" ]; then
                echo "Delete successfull" >> $TSOURCE/$FL
                say_this "say Delete successfull!"
        else    
                echo "Delete failed" >> $TSOURCE/$FL
                say_this "say Delete failed!"
                exit
        fi      
}  

#fdelete()
#{
#    say_this "say Deleting files 12 hours old or less!"
#    for i in `find $TSOURCE/*tar.gz -maxdepth 1 -mmin +310 -print`; do echo "Deleting $i"; rm $i; done
#        
#        if [ "$?" -eq "0" ]; then
#                echo "Delete successfull" >> $TSOURCE/$FL
#                say_this "say Delete successfull!"
#        else
#                echo "Delete failed" >> $TSOURCE/$FL
#                say_this "say Delete failed!"
#                exit
#        fi
#}



cr_get()
{
    cd $RSOURCE/crash-reports
    CRFILE="$(ls -t | head -1)"
    sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m $CRFILE -a $CRFILE
    #CROUT="$(cat $CRFILE)"
    #echo $CROUT
}

make_log()
{
    if [ -e $TSOURCE/$FL ]; then
        > $TSOURCE/$FL
        echo $NOW >> $TSOURCE/$FL
    else
        touch $TSOURCE/$FL
        echo #NOW >> $TSOURCE/$FL
    fi
}

send_log()
{
    if [ $? -eq 0 ]; then
        echo fail
        OUTPUT="$(cat $TSOURCE/$FL)"
        sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m $OUTPUT
    else
        echo success
        OUTPUT="$(cat $TSOURCE/$FL)"
        #sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m $OUTPUT

    fi
}

fcopy()
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

#fcopy()
#{
#    say_this "say Transfering files to NAS!"
#    for i in $GAFILE; do echo "Moving $i to NAS!"; cp -n $i $CPDEST; done
#
#        if [ "$?" -eq "0" ]; then
#                echo "Transfer successfull" >> $TSOURCE/$FL
#                say_this "say Transfer successfull!"
#        else
#                echo "Transfer failed" >> $TSOURCE/$FL
#                say_this "say transfer failed!"
#                send_log
#                exit
#        fi
#}

mount_checkNAS()
{
    if grep -qs $CPDEST /proc/mounts; then
        echo "It's mounted." >> $TSOURCE/$FL
        say_this "say NAS mounted!"
    else
        echo "It's not mounted." >> $TSOURCE/$FL
        say_this "say NSA not mounted backup failed!"
        send_log
        exit
    fi
}

mount_checkFON()
{
    if grep -qs $MCFON /proc/mounts; then
        echo "It's mounted." >> $TSOURCE/$FL
        say_this "say FON mounted!"
    else
        echo "It's not mounted." >> $TSOURCE/$FL
        say_this "say FON not mounted backup failed!"
        send_log
        exit
    fi
}

rsync_fun()
{
    echo "Starting rsync" >> $TSOURCE/$FL
    say_this "say Starting backup there may be lag!"
    rsync -avh $RSOURCE $RDEST

        if [ "$?" -eq "0" ]; then
            echo "rsync successfull" >> $TSOURCE/$FL
            say_this "say Backup successfull!"
        else
            echo "rsync failed" >> $TSOURCE/$FL
            say_this "say Backup failed!"
            send_log
            exit
        fi

}

tar_fun()
{
    echo "Starting tar" >> $TSOURCE/$FL
    say_this "say Taring file no lag for users!"
    tar -zcvf $TSOURCE/ygc_$NOW.tar.gz $TSOURCE/yogscastCompletePlus

        if [ "$?" -eq "0" ]; then
            echo "tar successfull" >> $TSOURCE/$FL
            say_this "say Tar successfull!"
        else
            echo "tar failed" >> $TSOURCE/$FL
            say_this "say Tar failed!"
            send_log
            exit
        fi
}

server_checker()
{
    
    say_this "say Test"
        if [ "$?" -eq "0" ]; then
            echo "Server running!"
            echo "Server running" >> $TSOURCE/$FL
            say_this "say PASS!"
        else
            echo "Server not running" >> $TSOURCE/$FL
            send_log
            exit
        fi
}

# This say_this() is old use the other one
#say_this()
#{
#    REEN="$(ssh -p 8989 192.168.1.101 screen -ls)"
#    echo $REEN > playground/log/log.txt
#    AWK="$(awk 'FNR == 1 { print $6 }' playground/log/log.txt)"
#    NAME="$(echo $AWK)"
#    ssh -p 8989 192.168.1.101 screen -S $NAME -p 0 -X stuff \"$1^M\"
#}

say_this()
{
    local name="$(ssh -p 8989 192.168.1.101 screen -ls | awk 'NR==2 {print $1}')"
    echo "$1"
    ssh -p 8989 192.168.1.101 screen -S "$name" -p 0 -X stuff \"$1^M\"
}

#save_off()
#{
#    $SSHSTUFF \"say Saving world\! $PF
#    $SSHSTUFF \"save-off $PF
#    $SSHSTUFF \"save-all $PF
#}

#save_on()
#{
#    $SSHSTUFF \"say Level saving enabled\! $PF
#    $SSHSTUFF \"save-on $PF
#}

exit_fun()
{
    echo "Bye!"; clear; exit
}

test_fun()
{
    echo "I did something!"
}

backup_fun()
{

    #clear_log
    make_log
    server_checker

    say_this "say Save disabled for backups!"
    say_this "save-off"
    say_this "save-all"

    sleep 5

    mount_checkFON


    rsync_fun


    say_this "save-on"


    tar_fun


    mount_checkNAS

    fcopy
   
    fdelete

    fdelete_nas


    say_this "say Operations complete"
}

