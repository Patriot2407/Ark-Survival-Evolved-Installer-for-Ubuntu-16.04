#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin	#Sets the PATH for CRON
# /usr/games/steamcmd +login anonymous +app_info_update 1 +app_info_print 376030 +quit # don't need, to much info
/usr/games/steamcmd +login anonymous +app_info_update 376030 +quit
exit 0