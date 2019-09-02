#!/bin/bash

INTERVAL=2

trap ctrl_c INT

function ctrl_c() {
    echo "** Terminating. Killing 'yes' processes."
    kill $pid1 $pid2 $pid3
    exit
}


timestamp() {
    echo $(date +%s)
}

TLAST=$(timestamp)

TNOW=$(timestamp)

TDIFF=$(( TNOW - TLAST ))

COUNTER=0

yes > /dev/null & pid1=$!
yes > /dev/null & pid2=$!
yes > /dev/null & pid3=$!

while true; do

((COUNTER++))

TNOW=$(timestamp)
TDIFF=$(( TNOW - TLAST ))

if [ $TDIFF -gt $INTERVAL ]
    then
        python checkThrottling.py
        vcgencmd measure_temp
        echo $COUNTER
        COUNTER=0
        TLAST=$TNOW
fi
done
