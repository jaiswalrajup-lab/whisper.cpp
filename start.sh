#!/bin/bash

set -e

mkdir -p models

MODEL_PATH="models/ggml-base.en.bin"

# Download ONLY if missing
if [ ! -f "$MODEL_PATH" ]; then
  echo "Downloading Whisper model..."
  curl -L --retry 5 --retry-delay 2 \
  -o "$MODEL_PATH" \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
fi

echo "Model ready. Starting server..."

exec ./build/bin/whisper-server \
  --host 0.0.0.0 \
  --port ${PORT:-10000} \
  --model "$MODEL_PATH"
