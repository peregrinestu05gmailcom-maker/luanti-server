# Install dependencies first to ensure SSL works for any future redirects
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    xz-utils \
    libgl1-mesa-glx \
    libopenal1 \
    libvorbis0a \
    libogg0 \
    libfreetype6 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Download using the DIRECT object storage URL (no redirect)
RUN curl -L "https://github.com/minetest/minetest/releases/download/5.9.0/minetest-5.9.0-linux-x86_64.tar.xz" \
    -H "Accept: application/octet-stream" \
    -o /tmp/luanti.tar.xz && \
    mkdir -p /opt/luanti && \
    tar -xf /tmp/luanti.tar.xz -C /opt/luanti --strip-components=1 && \
    chmod +x /opt/luanti/bin/luanti && \
    rm /tmp/luanti.tar.xz
