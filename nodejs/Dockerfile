FROM        --platform=$TARGETOS/$TARGETARCH node:18-bullseye-slim

LABEL       author="Ryujin" maintainer="ryudev.id@gmail.com"

# Install dependencies dan buat user container
RUN         apt update \
            && apt -y install imagemagick neofetch webp fonts-noto-color-emoji sudo ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev php php-curl libcurl4-openssl-dev python pip ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping libnss3 tini \
            && useradd -m -d /home/container container

RUN         apt -y install libnss3  libatk-bridge2.0-0 libatk1.0-0 libcups2 libxcomposite1 libxrandr2 libgbm1 libasound2 libxtst6 xdg-utils
RUN         apt -y install curl 
RUN         npm install typescript ts-node @types/node --location=global

RUN         npm i npm@10 -g --force && \
            npm i yarn -g --force && \
            npm i playwright -g && \
            npm i pm2 -g 

# Beralih ke user container setelah instalasi
USER        container
ENV         USER=container HOME=/home/container
ENV         PLAYWRIGHT_BROWSERS_PATH=/home/container/playwright-browsers

WORKDIR     /home/container

STOPSIGNAL SIGINT

# Copy entrypoint script dan beri hak akses
COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh

# Tentukan entrypoint dan command untuk kontainer
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
