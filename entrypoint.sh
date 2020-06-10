#!/bin/bash
echo "hostname "$Hostname"" >> /home/cs/csgo_server/csgo/cfg/server.cfg
echo "sv_maxrate 0" >> /home/cs/csgo_server/csgo/cfg/server.cfg
echo "sv_minrate 80000" >> /home/cs/csgo_server/csgo/cfg/server.cfg
echo "sm_cvar sv_maxcmdrate 128" >> /home/cs/csgo_server/csgo/cfg/server.cfg
echo "sv_mincmdrate 128" >> /home/cs/csgo_server/csgo/cfg/server.cfg
echo "sv_minupdaterate 128" >> /home/cs/csgo_server/csgo/cfg/server.cfg
echo "sm_cvar sv_maxupdaterate 128" >> /home/cs/csgo_server/csgo/cfg/server.cfg

groupadd cs -g ${GID:-1000}
useradd -u ${UID:-1000} -g ${GID:-1000} cs

chown -R cs:cs /home/cs/csgo_server
su cs -c '/home/cs/csgo_server/srcds_run -game csgo -console -usercon -maxplayers_override $MAXPLAYERS +game_type $GAMETYPE  +game_mode $GAMEMODE +mapgroup $MAPGROUP +map $STARTMAP +sv_setsteamaccount $TOKEN -authkey $WORKSHOPTOKEN +rcon_password $RCONPW +sv_password $PW +sv_region $REGION -tickrate $TICKRATE -net_port_try 1'
