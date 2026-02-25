FROM python:3 AS builder

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        libasound2-dev \
        pkg-config \
        ca-certificates \
        cargo && \
    rm -rf /var/lib/apt/lists/* && \
    # Setup Python env and deps \  
    python -m venv /venv && \
    . /venv/bin/activate && \
    pip install pocket-tts uvicorn fastapi && \
    # Build speakturbo \  
    git clone https://github.com/EmZod/Speak-Turbo.git /speakturbo-src && \
    . /venv/bin/activate && \
    cd /speakturbo-src/speakturbo-cli && \
    cargo build --release && \
    cd /speakturbo-src && \
    sed -i 's/IDLE_TIMEOUT_SECONDS = 3600/IDLE_TIMEOUT_SECONDS = 86400/' ./speakturbo/daemon_streaming.py && \
    pip install .

FROM python:3

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        vim \
        git \
        curl \
        ca-certificates \
        libnss-mdns \
        avahi-utils \
        iputils-ping \
        pulseaudio-utils \
        pipewire-bin \
        python-is-python3 \
        libasound2-dev \
        libasound2-plugins \
        git-delta \
    && rm -rf /var/lib/apt/lists/* && \
    mkdir -p /root/.local/bin && \
    # Setup bun \
    curl -fsSL https://bun.sh/install | bash && \
    mv /root/.bun/bin/bun /usr/local/bin/bun && \
    ln -sf /usr/local/bin/bun /usr/local/bin/bunx && \
    ln -sf /usr/local/bin/bun /usr/local/bin/node && \
    ln -sf /usr/local/bin/bunx /usr/local/bin/npx && \
    # Setup bun deps \
    bun install -g \
        opencode-ai@latest \
        @different-ai/opencode-browser@latest && \
    # Setup uv for calling desktop-agent \
    curl -LsSf https://astral.sh/uv/install.sh | sh && \
    # Ensure alsa has a default config to avoid errors (speakturbo) \
    echo 'pcm.!default { \n\
    type pulse \n\
    fallback "sysdefault" \n\
} \n\
\n\
ctl.!default { \n\
    type pulse \n\
}' > /root/.asoundrc

# copy our builds to our final build
COPY --from=builder /speakturbo-src/speakturbo-cli/target/release/speakturbo /root/.local/bin/speakturbo
COPY --from=builder /venv /venv
COPY --from=builder /venv/bin/speakturbo-daemon /root/.local/bin/speakturbo-daemon

ENV PATH="/workspace/.scripts:/root/.local/bin:${PATH}"

CMD ["/workspace/.scripts/opencode_entrypoint"]
