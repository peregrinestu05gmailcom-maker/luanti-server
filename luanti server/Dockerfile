FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install dependencies including jq for JSON parsing
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    xz-utils \
    jq \
    libgl1-mesa-glx \
    libopenal1 \
    libvorbis0a \
    libogg0 \
    libfreetype6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

# 2. Fetch the latest release asset URL dynamically
# This handles GitHub's redirects and finds the correct Linux binary
RUN echo "Fetching latest release info..." && \
    LATEST_VERSION=$(curl -s https://api.github.com/repos/minetest/minetest/releases/latest | jq -r '.tag_name') && \
    echo "Latest Version: $LATEST_VERSION" && \
    ASSET_URL=$(curl -s "https://api.github.com/repos/minetest/minetest/releases/tags/$LATEST_VERSION" | \
        jq -r '[.assets[] | select(.name == "minetest-'$LATEST_VERSION'-linux-x86_64.tar.xz")][0].browser_download_url') && \
    echo "Downloading from: $ASSET_URL" && \
    curl -L "$ASSET_URL" -o /tmp/luanti.tar.xz && \
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
