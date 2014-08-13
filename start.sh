#!/bin/bash

# General
mkdir -p /data/media /data/media/tv

# SickRage
mkdir -p /data/sickrage
if [ ! -f /data/sickrage/config.ini ]; then
  mv /app/sickrage/config.ini /data/sickrage/config.ini
fi
if [ ! -f /data/sickrage/sickbeard.db ]; then
  mv /app/sickrage/sickbeard.db /data/sickrage/sickbeard.db
fi
ln -nsf /data/sickrage/sickbeard.db /app/sickrage/sickbeard.db
ln -nsf /data/sickrage/config.ini /app/sickrage/config.ini
python /app/sickrage/SickBeard.py >> /log/sickrage &

# Deluge
touch /log/deluged /log/deluge-web
mkdir -p /data/torrents /data/torrents/completed /data/torrents/downloading \
  /data/torrents/blackhole
deluged -d -c /app/deluge -L info -l /log/deluged &
deluge-web -c /app/deluge -L info -l /log/deluge-web &

tail -f /log/sickrage -f /log/deluged -f /log/deluge-web
