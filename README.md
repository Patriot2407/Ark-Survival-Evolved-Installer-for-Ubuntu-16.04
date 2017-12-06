# Ark-Survival-Evolved-Installer-for-Ubuntu-16.04
Installs Ark: Survival evolved dedicated server on Ubuntu 16.04

To properly utilize everything in this repo, you need to run the Install_Ark_Server.sh first. This will add the necessary repos for the dedicated server, and will install steamcmd and install the Ark Game server in root directory /Ark.

After this is done, create a folder (preferably /Scripts) and put the update scripts and rcon.c in there. 

Run the rcon_compile_command.sh to install rcon for Ark on your server in that directory. 

Now you are able to use the update scripts and interface with rcon using Ubuntu's CLI. 

Just modify the locations at the tops of each script. 

I recommend running the Update_Forcer_Ark_Server.sh at the same time interval as Ark_autoupdate.sh, because there seems to be a problem with Linux not pulling build numbers correctly from steam. 

Use Cron to run Ark_autoupdate.sh every 15 minutes, along with Update_Forcer_Ark_Server.sh every 15 minutes. to do this run crontab -e and at the bottom input */15 * * * * /DIRECTORY/SCRIPT.sh


DISCLAIMER* I did NOT write the rcon.c file.
