FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git cmake build-essential curl

WORKDIR /app

COPY . .

RUN cmake -B build && cmake --build build -j

EXPOSE 8080

CMD ["./build/bin/whisper-server", "--host", "0.0.0.0", "--port", "8080"]
