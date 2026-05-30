#!/bin/bash

mkdir -p models

if [ ! -f models/ggml-base.en.bin ]; then
  echo "Downloading model..."
  curl -L -o models/ggml-base.en.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
fi

exec ./build/bin/whisper-server --host 0.0.0.0 --port 10000 --model models/ggml-base.en.bin
