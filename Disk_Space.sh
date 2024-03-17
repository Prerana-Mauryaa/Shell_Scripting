#!/bin/bash

#this script will monitor disk space daily and send email alerts if the free space goes beyond 85%

#fetching the used  space percent
Used_Space_Percent=df -h | grep "xvda15" | awk '{print $5}' | tr -d %

#mailid
to=preranamaurya012389@gmail.com
if [[ $Used_Space_Percent -ge 85  ]]
then
       echo "Alert: Disk space exceeds 85%, currently at $Used_Space_Percent %. Urgent action required to prevent data loss. Free up space or expand storage capacity immediately." | mail -s " DISK SPACE ALERT " $to
else
        echo "All Good!!"
fi
