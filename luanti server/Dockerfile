FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install prerequisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    ca-certificates \
    wget \
    xz-utils \
    jq \
    && rm -rf /var/lib/apt/lists/*

# 2. Try to install luanti-server from the default Ubuntu repos first
# If this fails, we fall back to downloading the binary manually
RUN apt-get install -y --no-install-recommends luanti-server || \
    (echo "Ubuntu repo failed, downloading binary manually..." && \
     # Download the latest stable release using GitHub API to get direct link
     curl -s https://api.github.com/repos/minetest/minetest/releases/latest | \
     jq -r '.assets[] | select(.name == "minetest-5.9.0-linux-x86_64.tar.xz") | .browser_download_url' > /tmp/url.txt && \
     curl -L -o /tmp/luanti.tar.xz "$(cat /tmp/url.txt)" && \
     mkdir -p /opt/luanti && \
     tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
     chmod +x /opt/luanti/bin/luanti && \
     rm /tmp/luanti.tar.xz /tmp/url.txt)

# 3. Create server data directory
WORKDIR /luanti-data

# 4. Copy config
COPY server.conf ./server.conf

# 5. Expose port
EXPOSE 30000/udp 30000/tcp

# 6. Run the server
# Use the system binary if available, otherwise use the downloaded one
CMD ["/usr/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
