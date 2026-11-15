FROM ubuntu:22.04

# Install Luanti and dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:minetest/ppa && \
    apt-get update && \
    apt-get install -y luanti-server && \
    mkdir -p /home/luanti/worlds/default

# Set working directory
WORKDIR /home/luanti

# Expose the game port
EXPOSE 30000

# Run the server
CMD ["luanti", "--server", "--world-path", "/home/luanti/worlds/default"]
