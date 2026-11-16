FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install all necessary tools first
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

# 2. Download Luanti Server v5.9.0
# We use -L to follow redirects from the API. 
# We also ensure we are parsing the correct JSON structure.
RUN curl -sL "https://api.github.com/repos/minetest/minetest/releases/tags/v5.9.0" | \
    jq -r '.assets[] | select(.name=="minetest-5.9.0-linux-x86_64.tar.xz") | .browser_download_url' | \
    xargs curl -L -o /tmp/luanti.tar.xz && \
    mkdir -p /opt/luanti && \
    tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
    chmod +x /opt/luanti/bin/luanti && \
    rm /tmp/luanti.tar.xz

# 3. Set working directory
WORKDIR /luanti-data

# 4. Copy config (ensure server.conf exists in your repo)
COPY server.conf ./server.conf

# 5. Expose port
EXPOSE 30000/udp 30000/tcp

# 6. Run server
CMD ["/opt/luanti/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
