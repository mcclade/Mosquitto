FROM debian:jessie

MAINTAINER James McCalden <james@mccalden.com>

RUN apt-get update 
RUN apt-get install -y wget
RUN wget -q -O - https://repo.mosquitto.org/debian/mosquitto-repo.gpg.key | apt-key add - 
RUN wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list https://repo.mosquitto.org/debian/mosquitto-jessie.list
RUN apt-get update 
RUN apt-get install -y mosquitto
RUN adduser --system --disabled-password --disabled-login mosquitto

RUN mkdir -p /mqtt/config /mqtt/data /mqtt/log

COPY config /mqtt/config
RUN chown -R mosquitto:mosquitto /mqtt
VOLUME ["/mqtt/config", "/mqtt/data", "/mqtt/log"]


EXPOSE 1883 9001
ENTRYPOINT /usr/sbin/mosquitto -c /mqtt/config/mosquitto.conf