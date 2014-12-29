#!/bin/bash

#ssh -p 8989 192.168.1.101 screen -S minecraft -X stuff \"say Starting backup. World is Readonly! $(printf '\r')\"

SSHSTUFF="ssh -p 8989 192.168.1.101 screen -S minecraft -X stuff"
PF=" $(printf '\r')\""
RSOURCE="/home/minecraft/mnt/nfs/minecraft/servers/minecraft/yogscastCompletePlus"
RDEST="/home/minecraft/backups/"
CPDEST="/home/minecraft/mnt/nfs/backup"
CPSOURCE="/home/minecraft/backups/"
TSOURCE="/home/minecraft/backups"
MCFON="/home/minecraft/mnt/nfs/minecraft"
NOW=$(date +%Y-%m-%d.%H:%M:%S)
EFROM="constraft@gmail.com"
SMTP="smtp.gmail.com:587"
ETO="fuzzyheadedfreak@gmail.com"
EPASS="a5c6d7f8z9"
FL="fuzzylog"
#CR="$(cat `ls -t $RSOURCE/crash-reports | head -1`)"


#sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m 

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
    touch $TSOURCE/$FL
}

send_log()
{
    if [ $? -eq 0 ]; then
        echo success
#        OUTPUT="$(cat $TSOURCE/$FL)"
#        sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m $OUTPUT
    else
        #echo fail
        OUTPUT="$(cat $TSOURCE/$FL)"
        sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m $OUTPUT

    fi
}

clear_log()
{
    > $TSOURCE/$FL
}

fcopy()
{
    $SSHSTUFF \"say Transfering files to NAS\! $PF
    for i in `find $TSOURCE/*tar.gz -maxdepth 1 -mmin +1 -print`; do echo "Moving $i to NAS!"; cp -n $i $CPDEST; done
    
        if [ "$?" -eq "0" ]; then
                echo "Transfer successfull" >> $TSOURCE/$FL
                $SSHSTUFF \"say Transfer successfull\! $PF
        else
                echo "Transfer failed" >> $TSOURCE/$FL
                $SSHSTUFF \"say transfer failed\! $PF
                exit
        fi
}

mount_checkNAS()
{
    if grep -qs $CPDEST /proc/mounts; then
        echo "It's mounted." >> $TSOURCE/$FL
        $SSHSTUFF \"say NAS mounted\! $PF
    else
        echo "It's not mounted." >> $TSOURCE/$FL
        $SSHSTUFF \"say NSA not mounted backup failed\! $PF
        exit
    fi
}

mount_checkFON()
{
    if grep -qs $MCFON /proc/mounts; then
        echo "It's mounted." >> $TSOURCE/$FL
        $SSHSTUFF \"say FON mounted\! $PF
    else
        echo "It's not mounted." >> $TSOURCE/$FL
        $SSHSTUFF \"say FON not mounted backup failed\! $PF
        exit
    fi
}

rsync_fun()
{
    echo "Starting rsync" >> $TSOURCE/$FL
    $SSHSTUFF \"say Starting backup there may be lag\! $PF
    rsync -avh $RSOURCE $RDEST
        
        if [ "$?" -eq "0" ]; then
            echo "rsync successfull" >> $TSOURCE/$FL
            $SSHSTUFF \"say Backup successfull\! $PF
        else
            echo "rsync failed" >> $TSOURCE/$FL
            $SSHSTUFF \"say Backup failed\! $PF
            exit
        fi

}

tar_fun()
{
    echo "Starting tar" >> $TSOURCE/$FL
    $SSHSTUFF \"say Tar\'ing file no lag for users\! $PF
    tar -zcvf $TSOURCE/ygc_$NOW.tar.gz $TSOURCE/yogscastCompletePlus

        if [ "$?" -eq "0" ]; then
            echo "tar successfull" >> $TSOURCE/$FL
            $SSHSTUFF \"say Tar successfull\! $PF
        else
            echo "tar failed" >> $TSOURCE/$FL
            $SSHSTUFF \"say Tar failed\! $PF
            exit
        fi
}

server_checker()
{
    $SSHSTUFF \"say Test $PF
        
        if [ "$?" -eq "0" ]; then
            echo "Server running" >> $TSOURCE/$FL
            $SSHSTUFF \"say PASS\! $PF
           # sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m Server Running
        else
            echo "Server not running"
            cr_get
            sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m Server DOWN
            exit
        fi
}

backup_fun()
{

    clear_log
    make_log
    server_checker

    $SSHSTUFF \"save-off $PF
    $SSHSTUFF \"save-all $PF
    sleep 5
   
    mount_checkFON


    rsync_fun 


    $SSHSTUFF \"save-on $PF


    tar_fun


    mount_checkNAS

    fcopy


    $SSHSTUFF \"say Operations complete\! $PF
}

backup_fun
send_log

