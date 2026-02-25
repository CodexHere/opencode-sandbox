FROM oven/bun:latest

RUN apt-get update && apt-get install -y \
    git \
    git-delta \
    docker-compose \
    ca-certificates \
    libnss-mdns \
    avahi-utils \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/* \
    && bun install -g opencode-ai \
    && echo "#/!bin/bash\nbunx \$@" > /usr/local/bin/npx \
    && chmod +x /usr/local/bin/npx

CMD ["opencode"]