This is a setup configuration for getting started with OpenCode using Ollama local hosted models. It provides a containerized development environment with everything needed to run OpenCode with local LLMs.

> **Note:** The default experience assumes Ollama is already installed and running on your host machine. If you prefer a completely self-contained setup with Ollama included, see the [Alternative Setup with Ollama](#alternative-setup-with-ollama) section below.

## Getting Started with OpenCode and Ollama Models

This project uses devcontainers by default to provide a fully functioning OpenCode environment. If your IDE supports devcontainers (like VS Code), simply open the project in your IDE and it will prompt you to reopen in a container. See [devcontainer.json](.devcontainer/devcontainer.json) and the [official devcontainer documentation](https://code.visualstudio.com/docs/devcontainers/containers) for more details.

### Building and Running Manually

If your IDE does not support devcontainers, you can build and run the container manually using Docker Compose:

```bash
docker compose -f .devcontainer/docker-compose.yml up --build
```

Once built, attach to the running container to access the OpenCode environment:

```bash
docker exec -it opencode-agent /bin/bash
```

To stop the container:

```bash
docker compose -f .devcontainer/docker-compose.yml down
```

### Alternative Setup with Ollama

If you don't have Ollama installed on your host, or want a completely self-contained setup, use the alternative compose file that includes Ollama and OpenWebUI services:

```bash
docker compose -f .devcontainer/docker-compose-ollama.yml up --build
```

This will start three services:

- **opencode** - The OpenCode agent container
- **ollama** - Ollama with GPU support (port 11434)
- **open-webui** - Optional web UI for Ollama (port 3000, auth disabled)

To stop:

```bash
docker compose -f .devcontainer/docker-compose-ollama.yml down
```

## Model Selection Requirements

To work well with OpenCode, ensure your selected models meet these criteria:

* Models must be pulled into Ollama from the provider's source repository (e.g., `qwen2.5:14b-instruct`)
* Adapted to fit a minimum context window of 64k tokens and uniquely named (e.g., `qwen2.5:14b-instruct-64k`)
* Configured within your OpenCode provider model map for seamless integration (see [opencode-example.json](.docs/ollama/opencode-example.json))

This project includes helper files to simplify setup:

* [opencode-example.json](.docs/ollama/opencode-example.json) - Example configuration with suggested models that work well with OpenCode
* [ollama_setup.sh](.scripts/ollama_setup.sh) - Helper script that pulls and configures models with 64k context window variants