#!/bin/bash

EFROM="constraft@gmail.com"
SMTP="smtp.gmail.com:587"
ETO="fuzzyheadedfreak@gmail.com"
EPASS="a5c6d7f8z9"
sendemail -f $EFROM -s smtp.gmail.com:587 -xu $EFROM -xp $EPASS -t $ETO -o tls=yes -m test
