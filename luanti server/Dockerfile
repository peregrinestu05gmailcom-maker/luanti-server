FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install curl, xz-utils, and jq (for parsing JSON)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    xz-utils \
    jq \
    && rm -rf /var/lib/apt/lists/*

# 2. Get the direct download URL from the GitHub API
# This avoids all redirect issues by getting the raw S3 link directly
RUN curl -s https://api.github.com/repos/minetest/minetest/releases/tags/5.9.0 | \
    jq -r '.assets[] | select(.name == "minetest-5.9.0-linux-x86_64.tar.xz") | .browser_download_url' > /tmp/download_url.txt && \
    curl -L -o /tmp/luanti.tar.xz "$(cat /tmp/download_url.txt)" && \
    mkdir -p /opt/luanti && \
    tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
    chmod +x /opt/luanti/bin/luanti && \
    rm /tmp/luanti.tar.xz /tmp/download_url.txt

# 3. Create server data directory
WORKDIR /luanti-data

# 4. Copy config
COPY server.conf ./server.conf

# 5. Expose port
EXPOSE 30000/udp 30000/tcp

# 6. Run the server with the full path
CMD ["/opt/luanti/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
