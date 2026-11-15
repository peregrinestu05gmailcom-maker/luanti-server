FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install basic tools and check if luanti is available in standard repos
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Try to install luanti from standard repos. 
# If this fails, we fallback to downloading the binary directly.
RUN if apt-cache show luanti > /dev/null 2>&1; then \
        apt-get install -y --no-install-recommends luanti luanti-data; \
    else \
        echo "Luanti not in standard repos, installing manually..."; \
        apt-get install -y --no-install-recommends wget ca-certificates; \
        wget -q https://github.com/luanti/luanti/releases/download/v5.13.0/luanti_5.13.0-1ubuntu22.04_amd64.deb -O /tmp/luanti.deb; \
        dpkg -i /tmp/luanti.deb || true; \
        apt-get install -f -y; \
        rm /tmp/luanti.deb; \
    fi

WORKDIR /luanti-data

COPY server.conf ./server.conf

EXPOSE 30000/udp 30000/tcp

CMD ["luanti", "--server", "--config", "/luanti-data/server.conf"]
