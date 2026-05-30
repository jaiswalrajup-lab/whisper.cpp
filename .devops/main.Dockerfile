FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git cmake build-essential curl bash

WORKDIR /app

COPY . .

RUN cmake -B build && cmake --build build -j

RUN chmod +x start.sh

EXPOSE 10000

CMD ["bash", "start.sh"]
