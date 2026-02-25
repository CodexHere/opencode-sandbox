FROM oven/bun:latest

RUN apt-get update && apt-get install -y \
    libnss-mdns \
    avahi-utils \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/* \
    && bun install -g opencode-ai

CMD ["opencode"]