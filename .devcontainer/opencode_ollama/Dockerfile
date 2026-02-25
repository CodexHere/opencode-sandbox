FROM ollama/ollama:latest

ENV PATH=$PATH:/workspace
WORKDIR /workspace

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        vim \
        git \
        curl \
        \
    && curl -fsSL https://llmfit.axjns.dev/install.sh | sh \
    && curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh -s -- --non-interactive

# Ensure `scripts` is defined as an additional context!
COPY --from=scripts . /workspace
