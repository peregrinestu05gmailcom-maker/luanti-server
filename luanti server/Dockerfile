# Use a standard Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install dependencies including ca-certificates for SSL support
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

# 2. Download the Luanti Server Binary via API to get the correct direct link
RUN curl -s https://api.github.com/repos/minetest/minetest/releases/tags/5.9.0 | \
    jq -r '.assets[] | select(.name=="minetest-5.9.0-linux-x86_64.tar.xz") | .browser_download_url' | \
    xargs curl -L -o /tmp/luanti.tar.xz && \
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
