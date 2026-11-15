FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install essential dependencies for the server and SSL support
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    xz-utils \
    libgl1-mesa-glx \
    libopenal1 \
    libvorbis0a \
    libogg0 \
    libfreetype6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

# 2. Download the Luanti Server Binary
# We use the direct object storage URL to avoid GitHub redirect issues
RUN curl -L "https://github.com/minetest/minetest/releases/download/5.9.0/minetest-5.9.0-linux-x86_64.tar.xz" \
    -H "Accept: application/octet-stream" \
    -o /tmp/luanti.tar.xz && \
    mkdir -p /opt/luanti && \
    tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
    chmod +x /opt/luanti/bin/luanti && \
    rm /tmp/luanti.tar.xz

# 3. Create the working directory for server data
WORKDIR /luanti-data

# 4. Copy your server configuration file
COPY server.conf ./server.conf

# 5. Expose the game port
EXPOSE 30000/udp 30000/tcp

# 6. Start the server
CMD ["/opt/luanti/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
