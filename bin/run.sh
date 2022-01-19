#!/bin/bash
set -ex
LOG_FILE=/tmp/autonomous_desk_$(date +"%Y-%m-%d").log
CHECK_ZOOM_STATUS=true

# Disallow concurrent runs
# https://stackoverflow.com/a/185473
LOCK_FILE=/tmp/autonomous_desk.lock
if [ -e ${LOCK_FILE} ] && kill -0 `cat ${LOCK_FILE}`; then
  echo $(date) run.sh Already running. Leaving... >> $LOG_FILE
  echo "Already running. Leaving..." >&2
  exit
fi
# make sure the lockfile is removed when we exit and then claim it
trap "rm -f ${LOCK_FILE}; exit" INT TERM EXIT
echo $$ > ${LOCK_FILE}
# /Disallow concurrent runs


echo ------------ >> $LOG_FILE
echo $(date) Entering run.sh >> $LOG_FILE

# If Zoom video on, wait... (only implemented for MacOS so far)
if [ "$CHECK_ZOOM_STATUS" = true ] && [[ $OSTYPE == 'darwin'* ]]
then
  while : 
  do
    ZOOM_STATUS=$(osascript ${0%/*}/zoomStatus.scpt)
    if [ $? -eq 0 ]
    then 
      echo $(date) Zoom status: $ZOOM_STATUS >> $LOG_FILE
      # If neither audio nor video are on, or only audio is on, proceed
      if [ -z "$ZOOM_STATUS" ] || [ "$ZOOM_STATUS" == "A" ]
      then
        echo $(date) Zoom video is not on. >> $LOG_FILE
        break
      fi
    fi
    echo $(date) Waiting for Zoom video to go off... >> $LOG_FILE
    sleep 10
  done
fi

echo $(date) Calling send_cmd.sh >> $LOG_FILE
. ${0%/*}/send_cmd.sh

rm -f ${LOCK_FILE}
echo $(date) Leaving run.sh >> $LOG_FILE

