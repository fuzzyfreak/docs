#!/bin/bash

source scriptVars.sh

INPUT="$1"

echo $INPUT

$SSHSTUFF \"say "$INPUT" $PF

echo $INPUT
