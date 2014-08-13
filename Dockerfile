FROM ubuntu:14.04
MAINTAINER Zach Latta <zach@zachlatta.com>

# General
RUN apt-get -y update && apt-get -y upgrade
VOLUME /data
VOLUME /log

# SickRage
RUN apt-get -y install python python-cheetah git
ADD https://github.com/echel0n/SickRage/archive/master.tar.gz \
  /app/sickrage.tar.gz
RUN tar xzf /app/sickrage.tar.gz -C /app && \
  mv /app/SickRage-master /app/sickrage && rm /app/sickrage.tar.gz
ADD sickrage/config.ini /app/sickrage/config.ini
EXPOSE 8081

# Deluge
RUN apt-get -y install deluged deluge-web
ADD deluge/core.conf /app/deluge/core.conf
EXPOSE 54323
EXPOSE 8112

ADD start.sh /bin/start.sh

# Initialization
CMD ["bash", "/bin/start.sh"]
