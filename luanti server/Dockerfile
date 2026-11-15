FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install only what we need to download and extract
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    tar \
    && rm -rf /var/lib/apt/lists/*

# Download the latest stable Luanti/Minetest server binary directly
# Using v5.9.0 as a stable baseline. If this link breaks, change the version.
RUN curl -L https://github.com/minetest/minetest/releases/download/5.9.0/minetest_5.9.0_linux_x86_64.tar.xz -o /tmp/luanti.tar.xz && \
    mkdir -p /opt/luanti && \
    tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
    rm /tmp/luanti.tar.xz

# Create a directory for your server data
WORKDIR /luanti-data

# Copy your configuration file
COPY server.conf ./server.conf

# Expose port
EXPOSE 30000/udp 30000/tcp

# Run the server using the full path to the binary
CMD ["/opt/luanti/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
