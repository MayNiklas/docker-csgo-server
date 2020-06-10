#!/bin/bash

# Template out the server config
sh -c 'echo "'"$(cat /server.cfg.template)"'" >> /home/cs/csgo_server/csgo/cfg/server.cfg'

# Set groups and permissions
groupadd cs -g ${GID:-1000}
useradd -u ${UID:-1000} -g ${GID:-1000} cs
chown -R cs:cs /home/cs/csgo_server

# Run the server as 'cs'
su cs -c '/home/cs/csgo_server/srcds_run\
	-authkey $WORKSHOPTOKEN\
	-console -usercon\
	-game csgo\
	-maxplayers_override $MAXPLAYERS\
	-net_port_try 1\
	-tickrate $TICKRATE'
