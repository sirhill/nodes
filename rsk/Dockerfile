#
# RSK Node Dockerfile
#

# Pull base image
FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends openjdk-8-jre systemd supervisor software-properties-common

# optional
RUN apt-get install -y less bash vim git

# Install rsk
RUN groupadd --gid 888 rsk && useradd rsk -d /var/lib/rsk -s /sbin/nologin --uid=888 --gid=888
RUN \
  add-apt-repository -y ppa:rsksmart/rskj && \
  apt-get update && \
  (echo rskj shared/accepted-rsk-license-v1-1 select true | /usr/bin/debconf-set-selections )&& \
  apt-get install -y --no-install-recommends rskj && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install self scripts
COPY run.sh /root/
RUN chmod +x /root/*.sh
COPY logback.xml /root/
COPY node.*.conf /root/

## MAINNET
EXPOSE 4444
EXPOSE 5050
EXPOSE 5050/udp

# Default command
CMD ["/root/run.sh"]

