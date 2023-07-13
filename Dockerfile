FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y

# Добавление репозитория ondrej/php
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php

RUN apt update && apt upgrade -y

RUN apt install supervisor wireguard python3 pip git nano net-tools iproute2 iptables -y

RUN wg genkey | tee /etc/wireguard/privatekey | wg pubkey | tee /etc/wireguard/publickey

RUN chmod 600 /etc/wireguard/privatekey

COPY wg0.conf /etc/wireguard/wg0.conf
RUN chmod 600 /etc/wireguard/wg0.conf

RUN echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

RUN sysctl -p

COPY . /

WORKDIR /
RUN chmod +x change_private.sh
RUN ./change_private.sh

RUN rm setup.sh

WORKDIR /wgdashboard/src

RUN chmod +x wgd.sh
RUN chmod +x /wgdashboard/src/wgd.sh

RUN ./wgd.sh install

WORKDIR /

RUN chmod -R 755 /etc/wireguard

EXPOSE 51820/udp
EXPOSE 10086

COPY supervisord.conf /etc/supervisor/supervisord.conf
ENTRYPOINT bash -c "/usr/bin/supervisord -c /etc/supervisor/supervisord.conf"
