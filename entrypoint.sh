#!/bin/sh

# Generate config and update server
# I can't bash so I wrote a python script
/usr/bin/python3 /home/container/ets_server_entrypoint.py

# Copy default server_packages if they do not exist
mkdir "/home/container/EuroTruckSimulator2/"
cp -n /default_packages/server_packages.sii "/home/container/EuroTruckSimulator2/"
cp -n /default_packages/server_packages.dat "/home/container/EuroTruckSimulator2/"
cd /home/container
mkdir /home/container/steamcmd
cd /home/container/steamcmd
tar -xvzf steamcmd_linux.tar.gz
./steamcmd +login anonymous +force_install_dir /home/container +app_update 1948160 +quit

echo "[INFO]: Starting server..."
exec "$@"
