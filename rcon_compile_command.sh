#!/bin/bash
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install gcc -y
sudo gcc -o rcon rcon.c
exit 0
