FROM debian:stable-slim
RUN apt-get update && \
    apt-get -y upgrade

RUN apt-get install -y \
    lib32gcc1 \
    lib32stdc++6 \
    wget \
    net-tools

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
