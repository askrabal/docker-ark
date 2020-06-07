FROM cm2network/steamcmd:root AS ark-install

USER 0
RUN useradd -u1001 -m -G games -s /bin/bash arksy
RUN cp -r /home/steam/steamcmd /home/arksy/
RUN mkdir -p /ark/ShooterGame/Saved
RUN chown -R arksy:arksy /ark /home/arksy
RUN chmod -R 755 /ark

FROM ark-install AS ark-final

USER 1001:1001
WORKDIR /home/arksy/steamcmd
RUN /home/arksy/steamcmd/steamcmd.sh \
    +login anonymous \
    +quit
RUN /home/arksy/steamcmd/steamcmd.sh \
    +login anonymous \
    +force_install_dir /ark \
    +app_update 376030 \
    +quit

CMD ["/ark/ShooterGame/Binaries/Linux/ShooterGameServer","TheIsland?listen?SessionName=dinoSlayer -server -log"]

