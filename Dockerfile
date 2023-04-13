FROM steamcmd/steamcmd:ubuntu

ARG APP_ID=1948160
ARG SAVEGAME_LOCATION="/home/container/EuroTruckSimulator2/"
ARG EXECUTABLE="/home/container/bin/linux_x64/eurotrucks2_server"
ARG DEFAULT_PACKAGES="default_packages/ets2"

# This mapping is needed to have the variables available at runtime. Args are only for build time
ENV SAVEGAME_LOCATION="${SAVEGAME_LOCATION}"
ENV ETS_SERVER_CONFIG_FILE_PATH="${SAVEGAME_LOCATION}/server_config.sii"
ENV EXECUTABLE=${EXECUTABLE}
ENV APP_ID=${APP_ID}

WORKDIR /home/container

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y python3 \
    && apk add curl
    && mkdir -p "${SAVEGAME_LOCATION}" \
    && mkdir -p /home/container/default_packages 

COPY ets_server_entrypoint.py /ets_server_entrypoint.py
COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

COPY ["${DEFAULT_PACKAGES}/server_packages.dat", "/default_packages/"]
COPY ["${DEFAULT_PACKAGES}/server_packages.sii", "/default_packages/"]

# needed for ETS server to find steamclient.so
ENV LD_LIBRARY_PATH='/home/container/linux64'

ENTRYPOINT [ "/entrypoint" ]
CMD [ "bash", "-c", "${EXECUTABLE}" ]
