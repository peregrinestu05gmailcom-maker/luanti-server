FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update system and install basic dependencies first
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Add the official Minetest/Luanti repository to ensure we get the correct version
RUN add-apt-repository ppa:minetest/minetest && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    luanti \
    luanti-data \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for server data
WORKDIR /luanti-data

# Copy configuration
COPY server.conf ./server.conf

# Expose port
EXPOSE 30000/udp 30000/tcp

# Run server
CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
