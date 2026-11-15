FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Install basic tools needed for downloading and fixing dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    dpkg \
    && rm -rf /var/lib/apt/lists/*

# 2. Download the latest stable Luanti .deb from GitHub
# We use v5.9.0 as it is a known stable LTS release. 
# If this link breaks in the future, change the version number in the URL.
RUN curl -L https://github.com/minetest/minetest/releases/download/5.9.0/minetest_5.9.0-1ubuntu22.04_amd64.deb -o /tmp/luanti.deb && \
    # 3. Install the deb and fix any missing dependencies automatically
    dpkg -i /tmp/luanti.deb || true && \
    apt-get install -f -y && \
    rm /tmp/luanti.deb

# 4. Create a directory for your server data
WORKDIR /luanti-data

# 5. Copy your configuration file
COPY server.conf ./server.conf

# 6. Expose the port
EXPOSE 30000/udp 30000/tcp

# 7. Run the server
CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
