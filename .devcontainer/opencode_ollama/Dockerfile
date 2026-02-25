FROM ollama/ollama:latest

ENV PATH=$PATH:/workspace
WORKDIR /workspace

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        vim \
        git \
        curl \
        \
    && curl -fsSL https://llmfit.axjns.dev/install.sh | sh

# Ensure `scripts` is defined as an additional context!
COPY --from=scripts . /workspace
