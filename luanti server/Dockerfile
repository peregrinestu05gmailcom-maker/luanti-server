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
    && rm -rf /var/lib/apt/lists/*

# 2. Add the official Minetest PPA
# This ensures we get the correct version and dependencies
RUN add-apt-repository ppa:minetest/ppa && \
    apt-get update

# 3. Install Luanti Server
# This installs 'luanti' binary and all required libraries automatically
RUN apt-get install -y --no-install-recommends luanti-server && \
    rm -rf /var/lib/apt/lists/*

# 4. Create server data directory
WORKDIR /luanti-data

# 5. Copy config
COPY server.conf ./server.conf

# 6. Expose port
EXPOSE 30000/udp 30000/tcp

# 7. Run the server
CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
