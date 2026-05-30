FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git cmake build-essential curl

WORKDIR /app

COPY . .

RUN cmake -B build && cmake --build build -j

# FORCE model download at build time
RUN mkdir -p models && \
    curl -L -o models/ggml-base.en.bin \
    https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin

EXPOSE 10000

CMD ["./build/bin/whisper-server", "--host", "0.0.0.0", "--port", "10000", "--model", "models/ggml-base.en.bin"]
