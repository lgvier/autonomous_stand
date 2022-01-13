#!/bin/bash
set -ex

DEVICE=/dev/cu.usbserial-A7004HWa

# start reading on the background
cat $DEVICE &
CATPID=$!

# wait for reading to start
sleep 5

# write the command
echo -ne 1 > $DEVICE

# wait for results
sleep 5
# stop reading
kill $CATPID

