#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin	#Sets the PATH for CRON
STEAMDIR=##
STEAMCMDDIR=##
SCRIPTDIR=##
#-------RCON--------
RCONDIR=##
RCONPASSWORD=##
RCONIP=127.0.0.1
RCONPORT=##
#--------------------
cd $SCRIPTDIR
if [ ! -f $SCRIPTDIR/ArkUpdateLogs/latestinstalledupdate.txt ] ; then
 touch $SCRIPTDIR/ArkUpdateLogs/latestinstalledupdate.txt
 echo "0" > $SCRIPTDIR/ArkUpdateLogs/latestinstalledupdate.txt
fi
sudo rm -fr $STEAMDIR/appcache
$STEAMCMDDIR/steamcmd +login anonymous +app_info_update 1 +app_info_print "376030" +quit | grep -EA 1000 "^\s+\"branches\"$" | grep -EA 5 "^\s+\"public\"$" | grep -m 1 -EB 10 "^\s+}$" | grep -E "^\s+\"buildid\"\s+" | tr '[:blank:]"' ' ' | tr -s ' ' | cut -d' ' -f3 > $SCRIPTDIR/ArkUpdateLogs/latestavailableupdate.txt
LATESTUPDATE=`cat $SCRIPTDIR/ArkUpdateLogs/latestavailableupdate.txt`
INSTALLEDUPDATE=`cat $SCRIPTDIR/ArkUpdateLogs/latestinstalledupdate.txt`
if [ "$LATESTUPDATE" != "$INSTALLEDUPDATE" ] && [ "$LATESTUPDATE" != "" ] && [ "$INSTALLEDUPDATE" != "" ]
	then
	echo "$(date) Update - $(echo $INSTALLEDUPDATE) to $(echo $LATESTUPDATE)" >> $(echo $SCRIPTDIR)/ArkUpdateLogs/AutoUpdatelog.txt
	$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT serverchat AUTOMATION: New update available!
	echo "$(date) There is a new Ark update available! The version available is: $LATESTUPDATE. Starting the Update process..." | mail -s "Ark Server Info" email@address
	$SCRIPTDIR/Update_Ark.sh
	$STEAMCMDDIR/steamcmd +login anonymous +app_info_update 1 +app_info_print "376030" +app_info_print "376030" +quit | grep -EA 1000 "^\s+\"branches\"$" | grep -EA 5 "^\s+\"public\"$" | grep -m 1 -EB 10 "^\s+}$" | grep -E "^\s+\"buildid\"\s+" | tr '[:blank:]"' ' ' | tr -s ' ' | cut -d' ' -f3 > $SCRIPTDIR/ArkUpdateLogs/latestinstalledupdate.txt
	else
	echo "$(date) No update available. Ark build-id: $INSTALLEDUPDATE" >> $(echo $SCRIPTDIR)/ArkUpdateLogs/`date +%F`-NoUpdatelog.txt
fi
