#!/bin/bash

set -e

BASE_DIR="/app"
MODEL_DIR="$BASE_DIR/models"
MODEL_PATH="$MODEL_DIR/ggml-base.en.bin"

mkdir -p "$MODEL_DIR"

echo "Checking model..."

if [ ! -f "$MODEL_PATH" ]; then
  echo "Downloading model..."
  curl -L --retry 5 \
  -o "$MODEL_PATH" \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
fi

echo "Model path: $MODEL_PATH"
ls -lh "$MODEL_DIR"

echo "Starting server..."

cd "$BASE_DIR"

exec ./build/bin/whisper-server \
  --host 0.0.0.0 \
  --port ${PORT:-10000} \
  --model "$MODEL_PATH"
