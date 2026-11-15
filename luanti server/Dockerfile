FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic dependencies first
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install the latest stable Luanti server binary
# Using v5.13.0 as a known stable release for Ubuntu 22.04 (Jammy)
RUN curl -L https://github.com/luanti/luanti/releases/download/v5.13.0/luanti_5.13.0-1ubuntu22.04_amd64.deb -o /tmp/luanti.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends /tmp/luanti.deb && \
    rm /tmp/luanti.deb

WORKDIR /luanti-data

COPY server.conf ./server.conf

EXPOSE 30000/udp 30000/tcp

CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
