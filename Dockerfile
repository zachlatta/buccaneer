FROM ubuntu:14.04
MAINTAINER Zach Latta <zach@zachlatta.com>

# General
RUN apt-get -y update
VOLUME /data
VOLUME /log
ADD start.sh /bin/start.sh

# SickRage
RUN apt-get -y install python python-cheetah git
ADD https://github.com/echel0n/SickRage/archive/master.tar.gz \
  /app/sickrage.tar.gz
RUN tar xzf /app/sickrage.tar.gz -C /app && \
  mv /app/SickRage-master /app/sickrage
RUN mkdir /data/sickbeard && \
  ln -s config.ini /data/sickbeard/ && \
  ln -s sickbeard.db /data/sickbeard/
WORKDIR /app/sickrage
EXPOSE 8081

# Initialization
CMD ["bash", "/bin/start.sh"]
