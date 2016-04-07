FROM debian:jessie

MAINTAINER James McCalden <james@mccalden.com>

RUN apt-get update 
RUN apt-get install -y wget
RUN wget -q -O - https://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add - 
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list https://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get update 
RUN apt-get install -y mosquitto
RUN apt-get install -y mosquitto-clients

COPY config/* /etc/mosquitto/conf.d

EXPOSE 1883 9001

ENTRYPOINT mosquitto -c /etc/mosquitto/mosquitto.conf