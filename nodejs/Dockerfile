FROM        --platform=$TARGETOS/$TARGETARCH node:21-bullseye-slim

LABEL       author="Ryujin" maintainer="ryudev.id@gmail.com"

RUN         apt update \
            && apt -y install imagemagick neofetch libwebp webp sudo python python-pip ffmpeg iproute2 git sqlite3 libsqlite3-dev python3 python3-dev php libcurl4-openssl-dev ca-certificates dnsutils tzdata zip tar curl build-essential libtool iputils-ping libnss3 tini \
            && useradd -m -d /home/container container

RUN         npm install typescript ts-node @types/node --location=global

RUN	    npm i npm@latest -g && \
            npm i yarn -g && \
	    npm i pm2 -g 
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT    ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]
