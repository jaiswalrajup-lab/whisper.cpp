FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git cmake build-essential curl

WORKDIR /app

COPY . .

# 🔥 MODEL DOWNLOAD (IMPORTANT FIX)
RUN mkdir -p models && \
    curl -L -o models/ggml-base.en.bin \
    https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin

RUN cmake -B build && cmake --build build -j

CMD ["bash", "start.sh"]
