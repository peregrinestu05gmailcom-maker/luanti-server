FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    dpkg \
    && rm -rf /var/lib/apt/lists/*

# Get the latest release URL dynamically
RUN LATEST_URL=$(curl -s https://api.github.com/repos/luanti/luanti/releases/latest | grep "browser_download_url.*amd64\.deb" | cut -d '"' -f 4) && \
    echo "Downloading from: $LATEST_URL" && \
    curl -L "$LATEST_URL" -o /tmp/luanti.deb && \
    apt-get install -y --no-install-recommends /tmp/luanti.deb && \
    rm /tmp/luanti.deb

WORKDIR /luanti-data

COPY server.conf ./server.conf

EXPOSE 30000/udp 30000/tcp

CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
