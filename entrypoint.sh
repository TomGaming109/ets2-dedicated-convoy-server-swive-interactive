#!/bin/sh

# Generate config and update server
# I can't bash so I wrote a python script
/usr/bin/python3 /home/container/ets_server_entrypoint.py

# Copy default server_packages if they do not exist
mkdir "/home/container/EuroTruckSimulator2/"
cp -n /default_packages/server_packages.sii "/home/container/EuroTruckSimulator2/"
cp -n /default_packages/server_packages.dat "/home/container/EuroTruckSimulator2/"
apt-get update && apt-get install steamcmd
steamcmd +login anonymous +app_update 1948160 +quit

echo "[INFO]: Starting server..."
exec "$@"
