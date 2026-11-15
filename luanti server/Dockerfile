FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install prerequisites for adding PPAs
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Add the official Minetest/Luanti PPA
# This PPA provides the 'luanti' package for Ubuntu
RUN add-apt-repository ppa:minetest/stable && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    luanti \
    luanti-data \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /luanti-data

COPY server.conf ./server.conf

EXPOSE 30000/udp 30000/tcp

CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
