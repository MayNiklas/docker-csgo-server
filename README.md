# docker-csgo-server

Since I haven't found a CS GO container I liked, I wrote my own.

Since the install is really big, you have to build the container on your host’s system. The install is stored within the container instead of the temporary Volume. This has the advantage of the game not redownloading every time you restart the container or change a parameter.

Starting the container takes around 2 minutes: I included a chmod -R command for the whole install in the entrypoint file. This way, the container can be listed under a UID / GUI of your choice, which will be helpful for resource management on your host’s server.

Feel free to fork the repository and change it to your liking!

I'm going to implement an update mechanism within the container soon!


### docker-compose.yml
All env's can be written within a docker-compose file. By building it yourself, you always install the latest install of the server!

```
version: '3'
services:
  csgo-server:
    container_name: csgo-server
    build: .
    ports:
      - "27015:27015/udp"
    environment:
      - TICKRATE=128      // 64 Ticks by default
#      - UID=
#      - GID=
#      - TOKEN=           // Include your CS Go API Server Key!
#      - WORKSHOPTOKEN=   // Needed to download workshop content
#      - Hostname=        
#      - MAXPLAYERS=
#      - GAMETYPE=
#      - GAMEMODE=
#      - MAPGROUP=
#      - STARTMAP=
#      - RCONPW=          // Set your RCON password here!
#      - PW=              // Set if password should be requirered to join
#      - REGION=          

    restart: unless-stopped
    stdin_open: true
    tty: true
```
