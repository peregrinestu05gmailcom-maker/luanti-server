FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install dependencies
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

# 2. Download the latest stable server binary directly from Minetest's CDN
# This URL is stable and does not require API parsing or follow redirects
RUN curl -L "https://github.com/minetest/minetest/releases/download/5.9.0/minetest-5.9.0-linux-x86_64.tar.xz" \
    -o /tmp/luanti.tar.xz && \
    mkdir -p /opt/luanti && \
    tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
    chmod +x /opt/luanti/bin/luanti && \
    rm /tmp/luanti.tar.xz

# 3. Create server data directory
WORKDIR /luanti-data

# 4. Copy config
COPY server.conf ./server.conf

# 5. Expose port
EXPOSE 30000/udp 30000/tcp

# 6. Run the server
CMD ["/opt/luanti/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
