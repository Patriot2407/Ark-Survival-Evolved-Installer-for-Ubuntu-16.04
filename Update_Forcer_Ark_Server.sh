#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin	#Sets the PATH for CRON
LogPath=/Scripts/ArkUpdateLogs/`date +%F`-FORCEDUPDATE.log
STEAMCMDDIR=##
# ---------------------------------------------------------------
cd /ArkUPDATER
$STEAMCMDDIR/steamcmd +login anonymous +force_install_dir /ArkUPDATER +app_update 376030 +quit &>> $LogPath
exit 0
