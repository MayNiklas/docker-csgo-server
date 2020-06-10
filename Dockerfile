FROM debian
RUN dpkg --add-architecture i386
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y gcc-multilib libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 libc6:i386 wget nano net-tools

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

COPY ./entrypoint.sh /
COPY ./server.cfg.template /
ENTRYPOINT ["sh", "/entrypoint.sh"]
