#!/bin/bash
sudo add-apt-repository multiverse 
sudo apt-get update
sudo apt-get update
sudo apt-get install steamcmd -y
sudo echo "fs.file-max=100000" >> /etc/sysctl.conf && sudo sysctl -p
sudo echo "* soft nofile 1000000" >> /etc/security/limits.conf
sudo echo "* hard nofile 1000000" >> /etc/security/limits.conf
echo "session required pam_limits.so" >> /etc/pam.d/common-session
if [ -d "/Ark" ]
	then
	echo "Ark directory already exists. Continuing on..."
	sudo chmod 777 /Ark
	else
	sudo mkdir /Ark
	sudo chmod -R 777 /Ark
	fi
cd /Ark
sudo ln -s /usr/games/steamcmd steamcmd
steamcmd +login anonymous +force_install_dir /Ark +app_update 376030 +quit
echo ""
echo -n "Please modify the ark.service file to fit your needs.Sessioname needs to be whatever you want to call your server, and others will see on the game. Change EXAMPLE to what you want. To change game map, modify the part that says Ragnarok? and chnage it to whatever map you want like TheIsland?"
read
sudo cp ark.service /lib/systemd/system/
sudo systemctl daemon-reload
exit 0
