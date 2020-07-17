RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y gcc-multilib libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 libc6:i386 wget nano net-tools
FROM debian:stable-slim

RUN mkdir -p /home/cs
WORKDIR /home/cs

RUN wget http://media.steampowered.com/client/steamcmd_linux.tar.gz
RUN tar xfvz steamcmd_linux.tar.gz
RUN ./steamcmd.sh +login anonymous +force_install_dir ./csgo_server/ +app_update 740 validate +quit

ENV	REGION=3 \
	MAXPLAYERS=10 \
	GAMETYPE=0 \
	GAMEMODE=1 \
	MAPGROUP="mg_bomb" \
	STARTMAP="de_dust" \
	TICKRATE=64

# For whatever reason, the original 'srcds_run' file is broken. It's using "steam.sh" instead of "steamcmd.sh"
RUN sed -i 's/steam.sh/steamcmd.sh/g' /home/cs/csgo_server/srcds_run

# Create the autoupdate script which is triggered when the round ends
RUN echo 'login anonymous\nforce_install_dir /home/cs/csgo_server/\napp_update 740 validate\nquit' >> /home/cs/autoupdate.sh \
    chmod +x /home/cs/autoupdate.sh

COPY ./entrypoint.sh /
COPY ./server.cfg.template /
ENTRYPOINT ["sh", "/entrypoint.sh"]
