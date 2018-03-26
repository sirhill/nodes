# Image definition
FROM alpine:3.6
RUN apk add --update bash vim less git
RUN apk add --update make g++ linux-headers go
WORKDIR /root

# Geth
RUN git clone https://github.com/ethereum/go-ethereum.git
RUN cd go-ethereum &&\
    git checkout release/1.8 &&\
    make all
ENV PATH=$PATH:/root/go-ethereum/build/bin

# Shell script
COPY run.sh /root/run.sh
RUN chmod +x /root/*.sh

# Misc
EXPOSE 30303
EXPOSE 30303/udp
EXPOSE 8545
EXPOSE 8546

CMD ["/root/run.sh"]

