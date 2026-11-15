FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install curl, xz-utils (for .tar.xz), and other basics
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# 2. Download the CORRECT binary directly from GitHub
# Note: The asset name is 'minetest-5.9.0-linux-x86_64.tar.xz' (hyphen, not underscore)
RUN curl -L https://github.com/minetest/minetest/releases/download/5.9.0/minetest-5.9.0-linux-x86_64.tar.xz -o /tmp/luanti.tar.xz && \
    mkdir -p /opt/luanti && \
    tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
    # Make sure the binary is executable
    chmod +x /opt/luanti/bin/luanti && \
    rm /tmp/luanti.tar.xz

# 3. Create server data directory
WORKDIR /luanti-data

# 4. Copy config
COPY server.conf ./server.conf

# 5. Expose port
EXPOSE 30000/udp 30000/tcp

# 6. Run the server with the full path
CMD ["/opt/luanti/bin/luanti", "--server", "--config", "/luanti-data/server.conf"]
