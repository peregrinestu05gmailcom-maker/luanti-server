FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# 1. Add the official Minetest PPA and install the server package
# This handles all dependencies (libgl, etc.) and versioning automatically
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    curl \
    && add-apt-repository ppa:minetest/ppa && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    luanti-server \
    && rm -rf /var/lib/apt/lists/*

# 2. Create server data directory
WORKDIR /luanti-data

# 3. Copy config
COPY server.conf ./server.conf

# 4. Expose port
EXPOSE 30000/udp 30000/tcp

# 5. Run the server using the system-installed binary
CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
