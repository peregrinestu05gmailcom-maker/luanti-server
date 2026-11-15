FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install wget, xz-utils, and ca-certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# 2. Download the server binary directly from the release page
# We use wget -c to handle redirects reliably and verify the file exists
RUN wget -q -O /tmp/luanti.tar.xz "https://github.com/minetest/minetest/releases/download/5.9.0/minetest-5.9.0-linux-x86_64.tar.xz" || \
    (echo "Download failed, trying alternative method..." && \
     wget -q -O /tmp/luanti.tar.xz "https://github.com/minetest/minetest/releases/download/5.9.0/minetest-5.9.0-linux-x86_64.tar.gz")

# 3. Extract the archive
# If it's .tar.xz, extract it. If it's .tar.gz, extract it.
RUN mkdir -p /opt/luanti && \
    if [ -f /tmp/luanti.tar.xz ]; then \
        tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1; \
    elif [ -f /tmp/luanti.tar.gz ]; then \
        tar -xzf /tmp/luanti.tar.gz -C /opt/luanti --strip-components=1; \
    else \
        echo "Archive not found!"; exit 1; \
    fi && \
    chmod +x /opt/luanti/bin/luanti && \
    rm /tmp/luanti.tar.xz /tmp/luanti.tar.gz

# 4. Create server data directory
WORKDIR /luanti-data

# 5. Copy config
COPY server.conf ./server.conf

# 6. Expose port
EXPOSE 30000/udp 30000/tcp

# 7. Run the server with the full path
CMD ["/opt/luanti/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
