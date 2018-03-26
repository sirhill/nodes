#
# BTC Node Dockerfile
#

# Pull base image
FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y --no-install-recommends software-properties-common

# optional
RUN apt-get install -y less bash vim git

# Install bitcoin
RUN groupadd --gid 555 bitcoin && useradd bitcoin -d /var/lib/bitcoin -s /sbin/nologin --uid=555 --gid=555
RUN \
  apt-add-repository -y ppa:bitcoin/bitcoin && \
  apt-get update && \
  apt-get install -y --no-install-recommends bitcoind && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install self scripts
COPY run.sh /root/
RUN chmod +x /root/*.sh

EXPOSE 8332
EXPOSE 8333
EXPOSE 18332
EXPOSE 18333

# Default command
CMD ["/root/run.sh"]

