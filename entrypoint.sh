#!/bin/bash

# Set groups and permissions
groupadd cs -g ${GID:-1000}
useradd -u ${UID:-1000} -g ${GID:-1000} cs
chown -R cs:cs /home/cs
chown cs:cs /server.cfg.template

su cs << EOF
FILE=""
DIR="/app"
if [ "$(ls -A $DIR)" ]; then
     echo "$DIR is not Empty. CS allready installed"
else
    echo "$DIR is Empty. CS is going to get installed"

# Install steamcmd and cs go as user 'cs'
wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
tar xfvz steamcmd_linux.tar.gz
./steamcmd.sh +login anonymous +force_install_dir ./csgo_server/ +app_update 740 validate +quit

# For whatever reason, the original 'srcds_run' file is broken. It's using "steam.sh" instead of "steamcmd.sh"
sed -i 's/steam.sh/steamcmd.sh/g' /home/cs/csgo_server/srcds_run

# Create the autoupdate script which is triggered when the round ends
echo 'login anonymous\nforce_install_dir /home/cs/csgo_server/\napp_update 740 validate\nquit' >> /home/cs/autoupdate.sh
chmod +x /home/cs/autoupdate.sh
fi

EOF

# Template out the server config
su cs -c 'rm /home/cs/csgo_server/csgo/cfg/server.cfg'
su cs -c 'echo "'"$(cat /server.cfg.template)"'" >> /home/cs/csgo_server/csgo/cfg/server.cfg'

# Run the server as 'cs'
su cs -c '/home/cs/csgo_server/srcds_run \
	-authkey $WORKSHOPTOKEN \
	-console -usercon \
	-game csgo \
	-maxplayers_override $MAXPLAYERS \
	-net_port_try 1 \
	-tickrate $TICKRATE \
	-autoupdate \
	-steamcmd_script /home/cs/autoupdate.sh \
	-steam_dir /home/cs'
