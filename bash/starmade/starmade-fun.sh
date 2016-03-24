#!/bin/bash

function STUFF() {
	SSHSTUFF="ssh -i /home/fuzzy/.ssh/CCfuzzy2 starmade@192.168.1.101 screen -S starmade -X stuff "\""$1 ^M"\"""
	$SSHSTUFF
}

STUFF "/server_message_broadcast plain Test_Again"
