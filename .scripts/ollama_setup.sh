#!/bin/bash

# List of your target base models
models=(
  "deepseek-coder-v2:16b"
  "deepseek-r1:8b"
  "deepseek-r1:14b"
  "ministral-3:8b-instruct"
  "ministral-3:14b-instruct"
  "qwen2.5:7b-instruct"
  "qwen2.5:14b-instruct"
  "qwen2.5-coder:3b-instruct"
  "qwen2.5-coder:14b-instruct"
  "qwen3-coder-next:q4_K_M"
)

echo "Destroying all previously known models with '64k' in the name, for safety" 
ollama list | awk '/64k/ {print $1}' | xargs -I {} ollama rm "{}"

for model in "${models[@]}"; do
  echo "---------------------------------------------------"
  echo "Targeting: $model"
  
  echo "Checking/Pulling $model..."
  ollama pull "$model"

  # give a 64k in the name
  new_name=$(echo "$model-64k")
  
  echo "Creating customized model: $new_name"
  
  # Create temporary Modelfile with 32k context
  cat <<EOF > Modelfile.tmp
FROM $model
PARAMETER num_ctx 65536
EOF

  ollama create "$new_name" -f Modelfile.tmp
  rm Modelfile.tmp
done

echo "---------------------------------------------------"
echo "All models are pulled and 64k-context optimized!"
