#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin	#Sets the PATH for CRON
RCONDIR=##
LogPath=$RCONDIR/ArkUpdateLogs/`date +%F`-log.log
RCONPASSWORD=##
RCONIP=127.0.0.1
RCONPORT=##
STEAMCMDDIR=##
email=email@address
#----------------------------------------------------------------------------------------------
status=$($RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT listplayers)
status2=$(echo ${status} | sed -e 's/^ *//g;s/ *$//g')
checker="No Players Connected"
checker2=$(echo ${checker} | sed -e 's/^ *//g;s/ *$//g')
if ! [[ $status2 == $checker2 ]]
	then
	$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT serverchat AUTOMATION: Server is going down for an update in 15 minutes!
	sleep 5m
	$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT serverchat AUTOMATION: Server is going down for an update in 10 minutes!
	sleep 5m
	$RCONDIR/rcon-P$RCONPASSWORD -a$RCONIP -p$RCONPORT serverchat AUTOMATION: Server is going down for an update in 5 minutes!
	sleep 5m
fi
status=$($RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT listplayers)
status2=$(echo ${status} | sed -e 's/^ *//g;s/ *$//g')
while ! [[ $status2 == $checker2 ]];
    do
	$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT serverchat Players detected! NOT Updating!
	$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT serverchat Please exit the game!
	sleep 1m
	status=$($RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT listplayers)
	status2=$(echo ${status} | sed -e 's/^ *//g;s/ *$//g')
done
$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT serverchat No Players detected! Updating...
$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT saveworld
$RCONDIR/rcon -P$RCONPASSWORD -a$RCONIP -p$RCONPORT Quit
sleep 30s
sudo systemctl stop ark
echo "-----------------------------------------------" &>> $LogPath
echo "starting update process at `date +%F_%H%M`" &>> $LogPath
echo "-----------------------------------------------" &>> $LogPath
$STEAMCMDDIR/steamcmd +login anonymous +force_install_dir /Ark +app_update 376030 +quit &>> $LogPath
echo "-----------------------------------------------" &>> $LogPath
echo "End update process at `date +%F_%H%M`" &>> $LogPath
echo "-----------------------------------------------" &>> $LogPath
sudo systemctl start ark
sudo systemctl status ark &>> $LogPath
mail -s "Ark Server Info" $email < $LogPath
exit 0
