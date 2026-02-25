# Ollama Setup Guide

This guide explains how to set up Ollama for use with 64k context models, which are required for certain AI capabilities in this project.

## Prerequisites

- Ollama installed on your system
- At least 16GB of RAM recommended for running large models

## Setting up 64k Context Models

There are two approaches for setting up 64k context models:

### Automated Setup

Run the provided setup script to automatically download and configure the required models:

```bash
chmod +x .scripts/ollama_setup.sh
/scripts/ollama_setup.sh
```

This script will:
- Pull the base models from Ollama
- Create custom 64k context versions of each model
- Configure each model with 32,768 context window size
- Clean up any previous 64k models for safety

### Manual Setup

If you prefer a manual approach, you can customize individual models using the Ollama `/set` command in the runtime:

1. Pull the base model:
```bash
ollama pull qwen3:30b-a3b
```

2. Start the model with 64k context:
```bash
ollama run qwen3:30b-a3b
```

3. In the Ollama interactive shell, set the context window:
```bash
/set parameter num_ctx 65536
/save qwen3:30b-a3b-64k
```

4. Exit the interactive shell:
```bash
/exit
```

Repeat this process for all desired models, using the appropriate base model name for each.
