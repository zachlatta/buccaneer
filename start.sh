#!/bin/bash

python /app/sickrage/SickBeard.py >> /log/sickrage &

tail -f /log/sickrage
