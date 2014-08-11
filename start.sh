#!/bin/bash

# SickRage
python /app/sickrage/SickBeard.py >> /log/sickrage &

# Deluge
touch /log/deluged /log/deluge-web
mkdir -p /data/torrents /data/torrents/completed /data/torrents/downloading \
  /data/torrents/blackhole
deluged -d -c /app/deluge -L info -l /log/deluged &
deluge-web -c /app/deluge -L info -l /log/deluge-web &

tail -f /log/sickrage -f /log/deluged -f /log/deluge-web
