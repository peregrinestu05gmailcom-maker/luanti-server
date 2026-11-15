FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools needed to download and extract
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Download the latest stable Luanti server binary directly from GitHub
# Using v5.9.0 as it is a very stable LTS version with known assets
RUN curl -L https://github.com/minetest/minetest/releases/download/5.9.0/minetest_5.9.0-1ubuntu22.04_amd64.deb -o /tmp/luanti.deb && \
    dpkg -i /tmp/luanti.deb || true && \
    apt-get install -f -y && \
    rm /tmp/luanti.deb

WORKDIR /luanti-data

COPY server.conf ./server.conf

EXPOSE 30000/udp 30000/tcp

CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
