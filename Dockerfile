FROM debian:stable-slim
RUN dpkg --add-architecture i386
RUN apt-get update &&\
    apt-get -y upgrade

RUN apt-get install -y\
    lib32gcc1\
    lib32stdc++6\
    libsdl2-2.0-0:i386\
    wget

RUN mkdir -p /home/cs
WORKDIR /home/cs

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
