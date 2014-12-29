#!/bin/bash

fdelete()
{
    $SSHSTUFF \"say Deleting files 12 hours old or less\! $PF
    for i in `find $TSOURCE/*tar.gz -maxdepth 1 -mmin +310 -print`; do echo "Deleting $i"; rm $i; done
        
        if [ "$?" -eq "0" ]; then
                echo "Delete successfull" >> $TSOURCE/$FL
                $SSHSTUFF \"say Delete successfull\! $PF
        else
                echo "Delete failed" >> $TSOURCE/$FL
                $SSHSTUFF \"say Delete failed\! $PF
                exit
        fi
}



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
    $SSHSTUFF \"say Transfering files to NAS\! $PF
    for i in `find $TSOURCE/*tar.gz -maxdepth 1 -mmin +1 -print`; do echo "Moving $i to NAS!"; cp -n $i $CPDEST; done

        if [ "$?" -eq "0" ]; then
                echo "Transfer successfull" >> $TSOURCE/$FL
                $SSHSTUFF \"say Transfer successfull\! $PF
        else
                echo "Transfer failed" >> $TSOURCE/$FL
                $SSHSTUFF \"say transfer failed\! $PF
                send_log
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
        send_log
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
        send_log
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
            send_log
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
            send_log
            exit
        fi
}

server_checker()
{
    $SSHSTUFF \"say Test $PF

        if [ "$?" -eq "0" ]; then
            echo "Server running!"
            echo "Server running" >> $TSOURCE/$FL
            $SSHSTUFF \"say PASS\! $PF
        else
            echo "Server not running" >> $TSOURCE/$FL
            send_log
            exit
        fi
}

save_off()
{
    $SSHSTUFF \"say Saving world\! $PF
    $SSHSTUFF \"save-off $PF
    $SSHSTUFF \"save-all $PF
}

save_on()
{
    $SSHSTUFF \"say Level saving enabled\! $PF
    $SSHSTUFF \"save-on $PF
}

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

    save_off

    sleep 5

    mount_checkFON


    rsync_fun


    save_on


    tar_fun


    mount_checkNAS

    fcopy
   
    #fdelete


    $SSHSTUFF \"say Operations complete\! $PF
}

