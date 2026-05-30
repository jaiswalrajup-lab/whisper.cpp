#!/bin/bash
set -e

echo "Starting Whisper Server..."

mkdir -p /app/models

MODEL="/app/models/ggml-base.en.bin"

if [ ! -f "$MODEL" ]; then
  echo "Downloading model..."
  curl -L --fail --retry 5 \
  -o "$MODEL" \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
fi

echo "Model exists:"
ls -lh /app/models

cd /app

exec ./build/bin/whisper-server \
  --host 0.0.0.0 \
  --port ${PORT:-10000} \
  --model "$MODEL"
