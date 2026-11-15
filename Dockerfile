# Use an official lightweight Ubuntu base image
FROM ubuntu:22.04

# Set environment variables to prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies: Luanti requires specific libraries for graphics/audio/networking
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    luanti \
    luanti-server \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for the server data
WORKDIR /luanti-data

# Copy the server configuration file into the container
COPY server.conf ./server.conf

# Expose the default Luanti port (UDP/TCP 30000)
EXPOSE 30000/udp 30000/tcp

# Run the Luanti server in headless mode (no GUI)
CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
