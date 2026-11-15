FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    luanti \
    luanti-server \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /luanti-data

COPY server.conf ./server.conf

EXPOSE 30000/udp 30000/tcp

CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
