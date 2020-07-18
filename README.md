# docker-csgo-server

---

## Quick Start

**NOTE**: The Docker command provided in this quick start is given as an example
and parameters should be adjusted to your need.

Launch the csgo-server docker container with the following command:
```
docker run --rm -d \
    -p "27015:27015/udp" \
    -p "27015:27015/tcp" \
    -e TOKEN=<API-token> \
    -v $(pwd)/cs-server:/home/cs \
    --name csgo-server \
    mayniki/csgo-server
```

Where:
  - `$(pwd)/cs-server:/home/cs`: This is where the application get's installed. In this case, your current directory is used.
  - `TOKEN`: Insert your API token

You can also use the following, in case you don't want persistant data on your system:
```
docker run --rm -d \
    -p "27015:27015/udp" \
    -p "27015:27015/tcp" \
    -e TOKEN=<API-token> \
    --name csgo-server \
    mayniki/csgo-server
```

## Motivation

Since I haven't found a CS GO container I liked, I wrote my own.

Since the install is really big, the Container just contains the instructions to download and install the game. The install is stored within a mounted volume instead of a temporary one. This has the advantage of the game not redownloading every time you
restart the container or change a parameter. The first time you star the container the game is getting installed and starts afterwards. Afterwards, it just starts the allready installed game. 

Feel free to fork the repository and change it to your liking.

## Updates

As soon there is a new version of the game, the server will wait untill the current game finishes. It will automatically update the game before restarting itself.

## Configuration template

Use `server.cfg.template` to add anything you'd like to include in the server
configuration. Variables will be replaced accordingly. This requires you to build the container yourself from this repository.

## docker-compose.yml

All env's can be written within a docker-compose file. They are written into the install every time you restart the container.


```
version: '3'
services:
  csgo-server:
    container_name: csgo-server
    build: .
    ports:
      - "27015:27015/udp"
      - "27015:27015/tcp" # Needed for RCON
    environment:
      - TICKRATE=128      # Set to 64 ticks by default
#      - UID=
#      - GID=
#      - TOKEN=           # Include your CS:GO API key
#      - WORKSHOPTOKEN=   # Needed to download workshop content
#      - CSGO_HOSTNAME=
#      - MAXPLAYERS=
#      - GAMETYPE=
#      - GAMEMODE=
#      - MAPGROUP=
#      - STARTMAP=
#      - RCONPW=          # Set your RCON password here!
#      - PW=              # Set if password should be requiered to join
#      - REGION=

    restart: unless-stopped
    stdin_open: true
    tty: true
```
