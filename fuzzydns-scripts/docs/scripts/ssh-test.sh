#!/bin/bash

SS=$(ssh -X -p 8989 192.168.1.101 'free -h')
CPU=$(ssh -X -p 8989 192.168.1.101 'top -bn1')


