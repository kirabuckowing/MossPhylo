#!/bin/bash

#This program uses a slack webhook to send a message to a channel there (after it has been set up with the right app), letting you know whenever this bash file is called. 
#Used within long jobs to alert the user when a portion of such finished (such as a single ID running through trinity or transdecoder, which could take hours and often needs to be run in the background, as through a screen).

#webhook_url=https://hooks.slack.com/services/APPCODE

curl -X POST -H 'Content-type: application/json' --data '{"text": "YOUR JOB/AN ID RUN/ETC has finished."}' https://hooks.slack.com/services/APPCODE
